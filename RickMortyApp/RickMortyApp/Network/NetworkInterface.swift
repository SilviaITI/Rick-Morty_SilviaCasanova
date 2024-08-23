//
//  NetworkInterface.swift
//  RickMortyApp
//
//  Created by Silvia Casanova Martinez on 21/8/24.
//

import SwiftUI

struct EmptyResponse: Codable {}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum NetworkInterface {
    case getAllCharacters(page: Int)
    case getCharactersFiltered(page: Int?, name: String?, status: String?)
}

extension NetworkInterface {
    var path: String {
        switch self {
        case .getAllCharacters,
                .getCharactersFiltered:
            return "/api/character"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAllCharacters,
                .getCharactersFiltered:
            return .get
        }
    }
    
    var query: [URLQueryItem]? {
        switch self {
        case .getAllCharacters(let page):
            return queryItem(["page": String(page)])
        case .getCharactersFiltered(let page, let name, let status):
            var params: [String:String] = [:]
            if let page {
                params["page"] = String(page)
             }
            if let name {
                params["name"] = name
            }
            if let status {
                params["status"] = status
            }
            return queryItem(params)
        }
    }
    
    var body: Data? {
        switch self {
        default: return nil
        }
    }
    
    var headers: [String: String]? {
        var header = NetworkInterface.defaultHeaders
        if let body {
            header["Content-Length"] = "\(body.count)"
        }
        return header
    }
    
    private static var defaultHeaders: [String: String] {
        let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        let device = UIDevice.current
        return [
            "Accept": "application/json",
            "Content-Type": "application/json",
            "appVersion": appVersion ?? "",
            "brand": device.name,
            "model": device.model,
            "os": device.systemName,
            "osVersion": device.systemVersion
        ]
    }
}



private func encodeParams(_ params: [String: String]) -> Data? {
    do {
        return try JSONEncoder().encode(params)
    } catch {
        return nil
    }
}

/// Método para crear los QueryItems
/// - Parameter params: Diccionario con la clave y el valor de la query
/// - Returns: devolverá el array de query items
private func queryItem(_ params: [String: String]) -> [URLQueryItem] {
    return params.map { key, value in
        URLQueryItem(name: key, value: value)
    }
}


