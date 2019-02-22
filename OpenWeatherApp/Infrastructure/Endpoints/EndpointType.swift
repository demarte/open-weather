//
//  EndpointType.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/14/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation

protocol EndpointType {
  var request: URLRequest? { get }
  var baseURL: URL { get }
  var path: String { get }
  var method: Method { get }
  var headers: [String: String]? { get }
  var parameters: [String: String]? { get }
}

extension EndpointType {
  var headers: [String: String]? {
    return nil
  }

  var baseURL: URL {
    return Constants.baseURL
      .appendingPathComponent(Constants.path)
      .appendingPathComponent(Constants.apiVersion)
  }

  var request: URLRequest? {
    return nil
  }
}
