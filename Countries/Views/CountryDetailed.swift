//
//  CountryDetailed.swift
//  Countries
//
//  Created by Alessandro Di Maio on 23/09/22.
//

import SwiftUI
import MapKit

struct CountryDetailed: View {
    
    @EnvironmentObject private var countryManager: CountryManager
    
    let country: Country
    
    @State private var mapFullScrenPresented = false
    @State private var region: MKCoordinateRegion
    
    init(country: Country) {
        self.country = country
        self._region = State(
            initialValue: .init(
                center: country.location,
                span: country.span
            )
        )
    }
    
    var body: some View {
        List {
            flagSection
            nameSection
            capitalSection
            languageSection
            numberSection
            mapSection
            currencySection
            tldSection
            bordersSection
        }
        .listStyle(.insetGrouped)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(country.name.common)
        .fullScreenCover(isPresented: $mapFullScrenPresented) {
            FullScreenMap(location: country.location, span: country.span)
        }
    }
}
//MARK: - Components
extension CountryDetailed {
    
    private var flagSection: some View {
        Section {
            FlagImage(url: country.flags.png)
                .listRowInsets(EdgeInsets())
        }
    }
    
    private var nameSection: some View {
        Section {
            Text(country.name.official)
                .font(.title2)
                .italic()
        } header: {
            Text("Official Name")
                .font(.callout)
        }
    }
    
    @ViewBuilder
    private var capitalSection: some View {
        if let capitalName = country.capital?.name {
            Section {
                Text(capitalName)
                    .font(.title2)
                    .italic()
            } header: {
                Text("Capital")
                    .font(.callout)
            }
        }
    }
    
    @ViewBuilder
    private var languageSection: some View {
        if let languages = country.languages {
            Section {
                ForEach(languages, id:\.self) { language in
                    Text(language)
                        .font(.title3)
                }
            } header: {
                Text("Languages")
                    .font(.callout)
            }
        }
    }
    
    private var numberSection: some View {
        Section {
            HStack {
                Text("Population:")
                    .font(.title3)
                    .bold()
                Text("\(country.population)")
                    .font(.body)
                Spacer()
            }
            HStack {
                Text("Area:")
                    .font(.title3)
                    .bold()
                Text(areaFormatted)
                    .font(.body)
                Spacer()
            }
        } header: {
            Text("Numbers")
                .font(.callout)
        }
    }
    
    private var mapSection: some View {
        Section {
            Map(coordinateRegion: $region, interactionModes: .zoom)
                .frame(minHeight: 400)
                .listRowInsets(EdgeInsets())
                .onTapGesture {
                    mapFullScrenPresented.toggle()
                }
        } header: {
            Text("Map")
                .font(.callout)
        }.accessibilityIdentifier("Map")
    }
    
    @ViewBuilder
    private var currencySection: some View {
        if !country.currencies.isEmpty {
            Section {
                ForEach(country.currencies, id: \.name) { currency in
                    HStack {
                        Text(currency.name)
                        Spacer()
                        Text(currency.ISO4217 ?? "")
                        Spacer()
                        Text(currency.symbol)
                    }.font(.title3)
                }
            } header: {
                HStack {
                    Text("Currencies")
                }.font(.callout)
            }
        }
    }
    
    @ViewBuilder
    private var tldSection: some View {
        if let tlds = country.tlds {
            Section {
                ForEach(tlds, id: \.self) { tld in
                    Text(tld)
                }
            } header: {
                HStack {
                    Text("Top Level Domains")
                }.font(.callout)
            }
        }
    }
    
    @ViewBuilder
    private var bordersSection: some View {
        if let borders = country.borders {
            Section {
                ForEach(borders, id: \.self) { border in
                    if let country = countryManager.getCountry(byCode: border) {
                        NavigationLink(country.name.common) {
                            CountryDetailed(country: country)
                        }
                    }
                }
            } header: {
                HStack {
                    Text("Borders")
                }.font(.callout)
            }
        }
    }
}
//MARK: - Computed Properties
extension CountryDetailed {
    private var areaFormatted: String {
        let measure = Measurement<UnitArea>(value: country.area, unit: .squareKilometers)
        return measure.formatted()
    }
}

struct CountryDetailed_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CountryDetailed(country: .italy)
                .environmentObject(
                    CountryManager(networkingService: NetworkingService())
                )
        }
    }
}
