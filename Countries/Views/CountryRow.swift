//
//  CountryRow.swift
//  Countries
//
//  Created by Alessandro Di Maio on 23/09/22.
//

import SwiftUI

struct CountryRow: View {
    
    let country: Country
    
    var body: some View {
        HStack {
            FlagImage(url: country.flags.png)
                .border(.tertiary)
                .frame(width: 80, height: 80)
                .padding(.trailing)
            VStack(alignment: .leading, spacing: 8) {
                Text(country.name.common)
                    .font(.headline)
                Text(country.continent.name)
            }.frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct CountryRow_Previews: PreviewProvider {
    static var previews: some View {
        CountryRow(country: .italy)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
