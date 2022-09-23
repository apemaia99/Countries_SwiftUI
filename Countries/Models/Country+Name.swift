//
//  Country+Name.swift
//  Countries
//
//  Created by Alessandro Di Maio on 23/09/22.
//

import Foundation

extension Country {
    struct Name: Codable {
        
        let common: String
        let official: String
        
        enum CodingKeys: CodingKey {
            case official
            case common
        }
    }
}
