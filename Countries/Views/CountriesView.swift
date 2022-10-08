//
//  CountriesView.swift
//  Countries
//
//  Created by Alessandro Di Maio on 23/09/22.
//

import SwiftUI

struct CountriesView: View {
    
    @EnvironmentObject private var countriesManager: CountriesManager
    @State private var searchField: String = ""
    @State private var selectedContinent: Country.Continent = .all
    
    var body: some View {
        NavigationStack {
            Group {
                if !countriesManager.countries.isEmpty {
                    List(countriesManager.filteredCountries.isEmpty ? countriesManager.countries : countriesManager.filteredCountries) { country in
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
                await countriesManager.loadCountries()
            }
        }
        .navigationViewStyle(.stack)
        .onChange(of: searchField) {
            $0.isEmpty ? countriesManager.filterCountries(by: selectedContinent) : countriesManager.filterCountries(by: $0)
        }
        .onChange(of: selectedContinent) {
            countriesManager.filterCountries(by: $0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CountriesView()
            .environmentObject(
                CountriesManager(networkingService: NetworkingService())
            )
    }
}
