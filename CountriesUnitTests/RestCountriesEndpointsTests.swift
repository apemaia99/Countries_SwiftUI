//
//  RestCountriesEndpointsTests.swift
//  CountriesUnitTests
//
//  Created by Alessandro Di Maio on 26/09/22.
//

import XCTest
@testable import Countries

class RestCountriesEndpointsTests: XCTestCase {
    
    func testAllCountriesEndpoint() throws {
        
        let expectedURL = URL(string: "https://restcountries.com/v3.1/all")!
        
        XCTAssertEqual(expectedURL, RestCountries.all.url)
    }
    
    func testCountryNameEndpoint() throws {
        
        let expectedURL = URL(string: "https://restcountries.com/v3.1/name/italy?fullText=true")!
        
        XCTAssertEqual(expectedURL, RestCountries.name("italy").url)
    }
    
    func testAcazzo() {
        var newCountry = Country(
            name: .init(common: "Italy", official: "Italian Republic"),
            continent: .europe,
            capital: .init(
                name: "Rome",
                location: .init(latitude: 41.9, longitude: 12.48)
            ),
            location: .init(latitude: 42.83333333, longitude: 12.83333333),
            tlds: [".it"],
            currencies: [.init(name: "Euro", symbol: "€", ISO4217: "EUR")],
            languages: ["Italian"],
            area: 301336.0,
            population: 59554023,
            flags: .init(
                png: URL(string: "https://flagcdn.com/w320/it.png")!,
                svg: URL(string: "https://flagcdn.com/it.svg")!
            )
        )
        
        newCountry.name.common = "asd"
        newCountry.continent = .africa
    }
}
