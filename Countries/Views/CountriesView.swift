//
//  CountriesView.swift
//  Countries
//
//  Created by Alessandro Di Maio on 23/09/22.
//

import SwiftUI

struct CountriesView: View {
    
    @EnvironmentObject private var countryManager: CountryManager
    @State private var searchField: String = ""
    @State private var selectedContinent: Country.Continent = .all
    
    var body: some View {
        NavigationStack {
            Group {
                if !countryManager.countries.isEmpty {
                    List(countryManager.filteredCountries.isEmpty ? countryManager.countries : countryManager.filteredCountries) { country in
                        NavigationLink(value: country) {
                            CountryRow(country: country)
                        }
                    }
                    .accessibilityIdentifier("countriesList")
                    .navigationDestination(for: Country.self) { country in
                        CountryDetailed(country: country)
                    }
                } else {
                    ProgressView("Loading")
                }
            }
            .navigationTitle("Countries")
            .searchable(
                text: $searchField,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Country Search"
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Picker("Continents", selection: $selectedContinent) {
                            ForEach(Country.Continent.allCases, id: \.self) { continent in
                                if continent != .none {
                                    Text(continent.name).tag(continent)
                                }
                            }
                        }.pickerStyle(.inline)
                    } label: {
                        Text(selectedContinent.name)
                    }
                }
            }
            .refreshable {
                await countryManager.loadCountries()
            }
        }
        .navigationViewStyle(.stack)
        .onChange(of: searchField) {
            $0.isEmpty ? countryManager.filterCountries(by: selectedContinent) : countryManager.filterCountries(by: $0)
        }
        .onChange(of: selectedContinent) {
            countryManager.filterCountries(by: $0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CountriesView()
            .environmentObject(
                CountryManager(networkingService: NetworkingService())
            )
    }
}
