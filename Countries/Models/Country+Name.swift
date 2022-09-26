//
//  Country+Name.swift
//  Countries
//
//  Created by Alessandro Di Maio on 23/09/22.
//

import Foundation

extension Country {
    struct Name: Codable, Equatable {
        
        var common: String
        var official: String
        
        enum CodingKeys: CodingKey {
            case official
            case common
        }
    }
}
