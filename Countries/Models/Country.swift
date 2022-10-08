//
//  Country.swift
//  Countries
//
//  Created by Alessandro Di Maio on 23/09/22.
//

import Foundation
import CoreLocation

struct Country: Identifiable, Decodable {
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
    
    init(from decoder: Decoder) throws {
        
        let root = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try root.decode(Name.self, forKey: .name)
        area = try root.decode(Double.self, forKey: .area)
        population = try root.decode(Int.self, forKey: .population)
        flags = try root.decode(Flag.self, forKey: .flags)
        code = try root.decode(String.self, forKey: .code)
        
        let latlng = try root.decode([CLLocationDegrees].self, forKey: .location)
        location = .init(latitude: latlng[0], longitude: latlng[1])
        
        continent = .init(
            rawValue: try root
                .decode([String].self, forKey: .continent)
                .first ?? ""
        ) ?? .none
        
        //MARK: - Catching errors for optionals values
        do {
            capital = try .init(from: decoder)
        } catch {
            print(Errors.missingKey("capital for \(self.name.common)"))
        }
        
        do {
            borders = try root.decode([String].self, forKey: .borders)
        } catch {
            print(Errors.missingKey("borders for \(self.name.common)"))
        }
        
        do {
            tlds = try root.decode([String].self, forKey: .tlds)
        } catch {
            print(Errors.missingKey("tld for \(self.name.common)"))
        }
        
        do {
            languages = try root
                .decode([String : String].self, forKey: .languages)
                .map(\.value)
        } catch {
            print(Errors.missingKey("languages for \(self.name.common)"))
        }
        
        do {
            let currencies = try root
                .decode([String : Currency].self, forKey: .currencies)
            
            for (key, currency) in currencies {
                self.currencies.append(
                    Currency(name: currency.name, symbol: currency.symbol, ISO4217: key)
                )
            }
        } catch {
            print(Errors.missingKey("currencies for \(self.name.common)"))
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case continent = "continents"
        case capital
        case location = "latlng"
        case borders
        case tlds = "tld"
        case code = "cca3"
        case currencies
        case languages
        case area
        case population
        case flags
    }
}
