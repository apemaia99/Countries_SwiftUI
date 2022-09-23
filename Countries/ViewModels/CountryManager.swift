//
//  CountryManager.swift
//  Countries
//
//  Created by Alessandro Di Maio on 23/09/22.
//

import Foundation

@MainActor
final class CountryManager: ObservableObject {
    
    @Published private(set) var countries: [Country] = []
    
    func test() async {
        let url = URL(string: "https://restcountries.com/v3.1/all")!
        do {
            countries = try await NetworkingService.fetchObject(for: url)
        } catch {
            print(error)
        }
    }
    
}
