//
//  Request.swift
//  KijijiTest
//
//  Created by Nuo Xu on 2019-12-17.
//  Copyright © 2019 Nuo Xu. All rights reserved.
//

import Foundation

/// A state of request. Either success with a generic return data model or a failure
enum Result<T> {
  case success(T)
  case failure(Error)
}

typealias RequestCompletion<T> = (Result<T>) -> Void

extension Client {
  
  /// This task method is designed to serialize a list of objects from a text file
  /// Text file contains another json object every different line
  ///
  /// After constructing the URLSession Data Task response data from text file converted into string
  /// Every line is decoded as the generic object type defined by the function
  /// Finally decoded response is appended into array of generic type
  ///
  /// - Parameters:
  ///   - endpoint: Endpoint that request hits
  ///   - completion: Result object with serialized object list or error
  /// - Returns: An optional URL Session Data Task
  func task<T>(endpoint: Endpoint<T>, _ completion: @escaping RequestCompletion<T>) -> URLSessionTask? {
    guard let request = buildURLRequest(endpoint: endpoint, headers: buildHeaders(extraHeaders: endpoint.headers)) else { return nil }
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      // error handling
      if let error = error {
        DispatchQueue.main.async {
          completion(.failure(error))
        }
      } else if let data = data {
        do {
          // try decoding data
          let response = try JSONDecoder().decode(T.self, from: data)
          DispatchQueue.main.async{
            completion(.success(response))
          }
        } catch let error { // error of decoding
          DispatchQueue.main.async {
            completion(.failure(error))
          }
        }
      } else {  // missing data error
        DispatchQueue.main.async {
          completion(.failure(NSError(domain: "Client Error", code: -1, userInfo: nil)))
        }
      }
    }
    
    task.resume()
    
    return task
  }
  
  /// Build up ulr request using a `Endpoint`
  private func urlRequest<T>(endpoint: Endpoint<T>) -> URLRequest? {
    return  buildURLRequest(endpoint: endpoint, headers: buildHeaders(extraHeaders: endpoint.headers))
  }
  
  /// Build up request headers
  private func buildHeaders(extraHeaders: HTTPHeaders) -> HTTPHeaders {
    var headers: HTTPHeaders = [:]
    // default header
    headers["Content-Type"] = "application/json"

    extraHeaders.forEach({
      if !headers.keys.contains($0.key) && !$0.value.isEmpty {
        headers[$0.key] = $0.value
      }
    })
   
    return headers
  }
  
  /// Build up request with enpoint and header
  private func buildURLRequest<T>(endpoint: Endpoint<T>, headers: HTTPHeaders) -> URLRequest? {
    let urlString = "\(endpoint.baseURL ?? configuration?.baseURL ?? "")\(endpoint.route)"
    
    guard let url = URL(string: urlString) else { return nil }
    var request = URLRequest(url: url)
    
    request.httpMethod = endpoint.method.rawValue
    
    for header in headers {
      request.addValue(header.value, forHTTPHeaderField: header.key)
    }
    
    return request
  }
  
}
