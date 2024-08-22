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
    case getCharacterByName(name: String)
}

extension NetworkInterface {
    var path: String {
        switch self {
        case .getAllCharacters,
                .getCharacterByName:
            return "/api/character"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAllCharacters,
                .getCharacterByName:
            return .get
        }
    }
    
    var query: [URLQueryItem]? {
        switch self {
        case .getAllCharacters(let page):
            return [URLQueryItem(name: "page", value: String(page))]
        case .getCharacterByName(let name):
            return [URLQueryItem(name: "name", value: name)]
        default:
            return nil
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

extension URLRequest {
    static func request(networkRequest: NetworkInterface) -> URLRequest {
        var components = URLComponents(string: "https://rickandmortyapi.com")
        components?.path = networkRequest.path
        
        if let query = networkRequest.query {
            components?.queryItems = query
        }
        
        guard let url = components?.url else {
            debugPrint("❌ URL is invalid")
            return URLRequest(url: URL(fileURLWithPath: ""))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = networkRequest.method.rawValue
        
        if let body = networkRequest.body {
            request.httpBody = body
        }
        
        request.allHTTPHeaderFields = networkRequest.headers
        
        var logMessage = "🚀 \(networkRequest.method.rawValue) \(url)"
        if let body = networkRequest.body {
            logMessage += " \(String(data: body, encoding: .utf8) ?? "")"
        }
        
        if let queryItems = networkRequest.query {
            let queryLog = queryItems.map { "\($0.name)=\($0.value ?? "")" }.joined(separator: "&")
            logMessage += "?\(queryLog)"
        }
        
        debugPrint("💡 Headers: \(request.allHTTPHeaderFields ?? [:])")
        
        return request
    }
}

private func encodeParams(_ params: [String: String]) -> Data? {
    do {
        return try JSONEncoder().encode(params)
    } catch {
        return nil
    }
}


