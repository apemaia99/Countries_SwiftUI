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
}
