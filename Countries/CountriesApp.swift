//
//  CountriesApp.swift
//  Countries
//
//  Created by Alessandro Di Maio on 23/09/22.
//

import SwiftUI

@main
struct CountriesApp: App {
    
    @StateObject private var countryManager: CountryManager
    
    init() {
        let networkingService = NetworkingService()
        //dependency Injection of external Services (also for injectind mocked services)
        _countryManager = StateObject(
            wrappedValue: CountryManager(networkingService: networkingService)
        )
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(countryManager)
        }
    }
}
