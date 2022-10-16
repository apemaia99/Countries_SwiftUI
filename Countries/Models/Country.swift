//
//  Country.swift
//  Countries
//
//  Created by Alessandro Di Maio on 23/09/22.
//

import Foundation
import CoreLocation

struct Country: Identifiable, Hashable {
    //INFO: model property are all var because we maybe want to be able to modify it. In context outside VMs, maybe for testing etc.
    let id = UUID()
    var name: Name
    var continent: Continent
    var capital: Capital?
    var location: CLLocationCoordinate2D
    var borders: [String]?
    var tlds: [String]?
    var code: String
    var currencies: [Currency] = []
    var languages: [String]?
    var area: Double
    var population: Int
    var flags: Flag
    
    init(
        name: Name,
        continent: Continent,
        capital: Capital? = nil,
        location: CLLocationCoordinate2D,
        borders: [String]? = nil,
        tlds: [String]? = nil,
        code: String,
        currencies: [Currency],
        languages: [String]? = nil,
        area: Double,
        population: Int,
        flags: Flag
    ) {
        self.name = name
        self.continent = continent
        self.capital = capital
        self.location = location
        self.borders = borders
        self.tlds = tlds
        self.code = code
        self.currencies = currencies
        self.languages = languages
        self.area = area
        self.population = population
        self.flags = flags
    }
}
