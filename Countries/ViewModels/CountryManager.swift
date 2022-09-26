//
//  CountryManager.swift
//  Countries
//
//  Created by Alessandro Di Maio on 23/09/22.
//

import Foundation

@MainActor
final class CountryManager: ObservableObject {
    //MARK: - Services(DI)
    let networkingService: NetworkingService
    //MARK: - ViewModel Properties
    //INFO these properties must be private(set) for security reason (no writing operation on data is allowed from views)
    @Published private(set) var countries: [Country] = []
    @Published private(set) var filteredCountries: [Country] = []
    //MARK: - Init
    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
    }
    //MARK: - Methods
    func loadCountries() async {
        do {
            countries = try await networkingService.fetchObject(for: RestCountries.all.url)
        } catch {
            print(error)
        }
    }
    
    func filterCountries(by continent: Country.Continent) {
        filteredCountries = countries.filter({ $0.continent == continent })
    }
    
    func filterCountries(by text: String) {
        filteredCountries = countries.filter({ $0.name.common.localizedCaseInsensitiveContains(text) })
    }
}
