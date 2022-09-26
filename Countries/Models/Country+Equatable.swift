//
//  Country+Equatable.swift
//  Countries
//
//  Created by Alessandro Di Maio on 26/09/22.
//

import Foundation

extension Country: Equatable {
    static func == (lhs: Country, rhs: Country) -> Bool {
        
        lhs.name == rhs.name &&
        lhs.continent == rhs.continent &&
        lhs.capital == rhs.capital &&
        lhs.location == rhs.location &&
        lhs.tlds == rhs.tlds &&
        lhs.currencies == rhs.currencies &&
        lhs.languages == rhs.languages &&
        lhs.area == rhs.area &&
        lhs.population == rhs.population &&
        lhs.flags == rhs.flags
        
    }
}
