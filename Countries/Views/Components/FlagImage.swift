//
//  FlagImage.swift
//  Countries
//
//  Created by Alessandro Di Maio on 23/09/22.
//

import SwiftUI

struct FlagImage: View {
    
    let url: URL
    
    var body: some View {
        AsyncImage(url: url) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Color.secondary
            } else {
                ProgressView()
            }
        }
    }
}

struct CountryFlagImage_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage(url: Country.italy.flags.png)
    }
}
