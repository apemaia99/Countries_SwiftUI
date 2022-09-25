//
//  ContentView.swift
//  Countries
//
//  Created by Alessandro Di Maio on 23/09/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var countryManager: CountryManager
    @State private var searchField: String = ""
    @State private var selectedContinent: Country.Continents = .all
    
    var body: some View {
        NavigationView {
            Group {
                if !countryManager.countries.isEmpty {
                    List(countryManager.filteredCountries.isEmpty ? countryManager.countries : countryManager.filteredCountries) { country in
                        NavigationLink {
                            CountryDetailed(country: country)
                        } label: {
                            CountryRow(country: country)
                        }
                    }
                } else {
                    ProgressView("Loading")
                }
            }
            .navigationTitle("Countries")
            .searchable(text: $searchField, placement: .toolbar, prompt: "Find a Country")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Picker("Continents", selection: $selectedContinent) {
                            ForEach(Country.Continents.allCases, id: \.self) { continent in
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
        }
        .navigationViewStyle(.stack)
        .onChange(of: searchField) {
            $0.isEmpty ? countryManager.filterCountries(by: selectedContinent) : countryManager.filterCountries(by: $0)
        }
        .onChange(of: selectedContinent) {
            countryManager.filterCountries(by: $0)
        }
        .task {
            await countryManager.loadCountries()
        }
        .refreshable {
            await countryManager.loadCountries()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(
                CountryManager(networkingService: NetworkingService())
            )
    }
}
