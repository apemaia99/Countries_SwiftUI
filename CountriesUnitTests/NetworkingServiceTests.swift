//
//  NetworkingServiceTests.swift
//  Countries
//
//  Created by Alessandro Di Maio on 26/09/22.
//

import XCTest
@testable import Countries

class NetworkingServiceTests: XCTestCase {
    
    let networkService = NetworkingService()
    
    func test200OK() async {
        
        let url = URL(string: "https://restcountries.com/v3.1/name/italy?fullText=true")!
        
        do {
            let _: [Country] = try await networkService.fetchObject(for: url)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func test404BadRequest() async {
        
        let url = URL(string: "https://restcountries.com/v3.1/nama")!
        
        do {
            let _: [Country] = try await networkService.fetchObject(for: url)
        } catch {
            XCTAssertEqual(error as! NetworkingService.Error, NetworkingService.Error.request(404))
        }
    }
    
    func testMalformedUrl() async {
        let url = URL(string: "restcountries.com")!
        
        do {
            let _: [Country] = try await networkService.fetchObject(for: url)
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
