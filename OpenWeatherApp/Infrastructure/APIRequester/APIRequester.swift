//
//  APIRequester.swift
//  OpenWeatherApp
//
//  Created by Ivan De Martino on 2/14/19.
//  Copyright © 2019 Ivan De Martino. All rights reserved.
//

import Foundation
//Qualquer tipo generico que implemente um EndpointType
struct APIRequester<Endpoint: EndpointType> {
  //Qualquer tipo generico que implemente Decodable
  func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T>) -> Void) {
    //Cria uma URLRequest a partir de um implementador de EndpointType
    var request = create(endpoint)
    //Adiciona o dictionary headers a propriedade headers da URLRequest
    endpoint.headers?.forEach { (key, value) in
      request.addValue(value, forHTTPHeaderField: key)
    }
    URLSession.shared.dataTask(with: request) { (data, response, error) in
      guard let response = response,
        let data = data else {
          completion(Result.failure(APIRequesterError.noData))
          return
      }
      //Faz o cast se possivel da response para uma URLResponse
      guard let httpResponse = response as? HTTPURLResponse,
        200..<300 ~= httpResponse.statusCode else {
          completion(Result.failure(APIRequesterError.invalidResponse))
          return
      }
      //Faz o parse da data para o objeto que esta de acordo com o protocolo Decodable
      do {
        let parsedObject = try JSONDecoder().decode(T.self, from: data)
        completion(Result.success(parsedObject))
      } catch {
        completion(Result.failure(error))
      }
    }.resume()
  }
  private func create(_ endpoint: Endpoint) -> URLRequest {
    //faz o unwrap da propriedade request do endpoint e retorna essa request
    //caso o implementador do EndpointType ja tenha criado a URLRequest, a funcao retorna
    if let request = endpoint.request { return request }
    //pega a URL padrao do endpoint (baseURL).
    //verifica se existe um path no endpoint. Caso exista, sera acrescentada a essa baseURL
    let url: URL = {
      if endpoint.path.isEmpty {
        return endpoint.baseURL
      } else {
        return endpoint.baseURL.appendingPathComponent(endpoint.path)
      }
    }()
    //Cria uma URLComponents passando a url
    var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
    //Caso o metodo do endpoint seja GET:
    //Pega o dictionary de parameters do endpoint, e pra cada Key e Value cria um array de URLQueryItem.
    //Caso o dictionary de parameters esteja vazio retornara um array vazio
    //Adiciona ha propriedade do URLComponents o array de URLQueryItems
    if endpoint.method == .get {
      let queryItems = endpoint.parameters?.compactMap { URLQueryItem(name: $0.key, value: $0.value) } ?? []
      urlComponents?.queryItems = queryItems
    }
    //Cria uma URLRequest a partir da URLComponets se tiver valor, caso nao tenha cria a partir da URL
    var request = URLRequest(url: urlComponents?.url ?? url)
    //Adiciona o metodo HTTP do endpoint a propriedade da URLRequest
    request.httpMethod = endpoint.method.rawValue
    //Caso o metodo do endpoint nao seja GET:
    //Tenta criar um JSON com o dictionary de parameters do endpoint
    //Se der certo adiciona ao body da URLRequest
    if endpoint.method != .get {
      let dataParam = try? JSONSerialization.data(withJSONObject: endpoint.parameters ?? [], options: [])
      request.httpBody = dataParam
    }
    return request
  }
}
