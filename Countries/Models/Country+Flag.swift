//
//  Country+Flag.swift
//  Countries
//
//  Created by Alessandro Di Maio on 23/09/22.
//

import Foundation

extension Country {
    struct Flag: Codable {
        
        let png: URL
        let svg: URL
        
        enum CodingKeys: CodingKey {
            case png
            case svg
        }
    }
}
