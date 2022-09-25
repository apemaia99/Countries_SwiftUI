//
//  Country.swift
//  Countries
//
//  Created by Alessandro Di Maio on 23/09/22.
//

import Foundation
import CoreLocation

struct Country: Identifiable, Decodable {
    
    let id = UUID()
    let name: Name
    let continent: Continents
    var capital: Capital?
    
    let location: CLLocation
    var tlds: [String]?
    var currencies: [Currency] = []
    var languages: [String]?
    let area: Double
    let population: Int
    let flags: Flag
    
    init(
        name: Name,
        continent: Continents,
        capital: Capital? = nil,
        location: CLLocation,
        tlds: [String]? = nil,
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
        self.tlds = tlds
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
        
        let latlng = try root.decode([CLLocationDegrees].self, forKey: .location)
        location = .init(latitude: latlng[0], longitude: latlng[1])
        
        continent = .init(
            rawValue: try root
                .decode([String].self, forKey: .continent)
                .first ?? ""
        ) ?? .none
        
        do {
            capital = try .init(from: decoder)
            
            do {
                tlds = try root.decode([String].self, forKey: .tlds)
            } catch {
                throw Errors.missingKey("tld")
            }
            
            do {
                languages = try root
                    .decode([String : String].self, forKey: .languages)
                    .map(\.value)
            } catch {
                throw Errors.missingKey("languages")
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
                throw Errors.missingKey("currencies")
            }
        } catch {
            print("\(error) for \(self.name.common)")
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case continent = "continents"
        case capital
        case location = "latlng"
        case tlds = "tld"
        case currencies
        case languages
        case area
        case population
        case flags
    }
}
