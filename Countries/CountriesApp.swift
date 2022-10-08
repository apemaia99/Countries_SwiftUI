//
//  CountriesApp.swift
//  Countries
//
//  Created by Alessandro Di Maio on 23/09/22.
//

import SwiftUI

@main
struct CountriesApp: App {
    
    @StateObject private var countriesManager: CountriesManager
    
    init() {
        let networkingService = NetworkingService()
        //INFO: dependency Injection of external Services (also for injecting mocked services)
        _countriesManager = StateObject(
            wrappedValue: CountriesManager(networkingService: networkingService)
        )
    }
    
    var body: some Scene {
        WindowGroup {
            CountriesView()
                .environmentObject(countriesManager)
        }
    }
}
