//
//  ContentView.swift
//  Countries
//
//  Created by Alessandro Di Maio on 23/09/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var countryManager: CountryManager
    
    var body: some View {
        NavigationView {
            Group {
                if !countryManager.countries.isEmpty {
                    List(countryManager.countries) { country in
                        Text(country.name.common)
                    }
                } else {
                    ProgressView("Loading")
                }
            }
            .navigationTitle("Countries")
            .task {
                await countryManager.test()
            }
        }.navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CountryManager())
    }
}
