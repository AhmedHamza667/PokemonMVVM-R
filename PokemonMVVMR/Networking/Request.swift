//
//  Request.swift
//  PokemonMVVMR
//
//  Created by Ahmed Hamza on 3/13/25.
//

import Foundation


protocol Requestable {
    var baseURL:String {get}
    var path:String {get}
    var header: [String:String]{get}
    var paramerters: [String:String] {get}
    var type:String {get}
    func createURLRequest () -> URLRequest?
}

extension Requestable{
    var baseURL:String {
        return APIEndpoints.baseURL
    }
    var header: [String:String]{
        return [:]
    }
    func createURLRequest () -> URLRequest? {
        guard baseURL.count > 0, path.count > 0 else {
            return nil
        }
        var urlComponent = URLComponents(string: "\(baseURL)\(path)")
        
        var queryParameters:[URLQueryItem] = []
        
        for (key,value) in paramerters {
            queryParameters.append(URLQueryItem(name: key,value: value))
        }
        urlComponent?.queryItems = queryParameters
        guard let url = urlComponent?.url else {
            return nil
        }
        let request = URLRequest(url: url)
        return request
    }
}
