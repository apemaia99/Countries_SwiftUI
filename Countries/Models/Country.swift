//
//  Country.swift
//  Countries
//
//  Created by Alessandro Di Maio on 23/09/22.
//

import Foundation
import CoreLocation

struct Country: Identifiable, Codable {
    
    let id = UUID()
    let name: Name
    let continent: Continents
    var capital: Capital?
    
    let location: CLLocation
    var tld: [String]?
    var currencies: [Currency]?
    var languages: [String]?
    let area: Double
    let population: Int
    let flags: Flag
    
    init(
        name: Name,
        continent: Continents,
        capital: Capital? = nil,
        location: CLLocation,
        tld: [String]? = nil,
        currencies: [Currency]? = nil,
        languages: [String]? = nil,
        area: Double,
        population: Int,
        flags: Flag
    ) {
        self.name = name
        self.continent = continent
        self.capital = capital
        self.location = location
        self.tld = tld
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
                tld = try root.decode([String].self, forKey: .tld)
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
                currencies = try root
                    .decode([String : Currency].self, forKey: .currencies)
                    .map(\.value)
            } catch {
                throw Errors.missingKey("currencies")
            }
        } catch {
            print("\(error) for \(self.name.common)")
        }
    }
    
    func encode(to encoder: Encoder) throws {
        throw Errors.notImplemented
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case continent = "continents"
        case capital
        case location = "latlng"
        case tld
        case currencies
        case languages
        case area
        case population
        case flags
    }
}
