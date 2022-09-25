//
//  Country+Currency.swift
//  Countries
//
//  Created by Alessandro Di Maio on 23/09/22.
//

import Foundation

extension Country {
    struct Currency: Decodable {
        
        let name: String
        let symbol: String
        var ISO4217: String?
        
        enum CodingKeys: CodingKey {
            case name
            case symbol
        }
    }
}
