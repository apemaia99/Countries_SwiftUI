//
//  RestCountries.swift
//  Countries
//
//  Created by Alessandro Di Maio on 24/09/22.
//

import Foundation

enum RestCountries {
    case all
    case name(String)
    case code(String)
    
    var url: URL {
        
        var final = URLComponents()
        
        final.scheme = "https"
        final.host = "restcountries.com"
        final.path = "/v3.1/"
        
        switch self {
        case .all:
            final.path += "all"
        case .name(let name):
            let parameter = URLQueryItem(name: "fullText", value: "true")
            final.path += "name/" + name
            final.queryItems = [parameter]
        case .code(let code):
            final.path += "alpha/" + code
        }
        
        return final.url!
    }
}
