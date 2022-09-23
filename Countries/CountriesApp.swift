//
//  CountriesApp.swift
//  Countries
//
//  Created by Alessandro Di Maio on 23/09/22.
//

import SwiftUI

@main
struct CountriesApp: App {
    
    @StateObject private var countryManager = CountryManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(countryManager)
        }
    }
}
