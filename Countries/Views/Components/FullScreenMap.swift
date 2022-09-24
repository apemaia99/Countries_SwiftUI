//
//  FullScreenMap.swift
//  Countries
//
//  Created by Alessandro Di Maio on 24/09/22.
//

import SwiftUI
import MapKit

struct FullScreenMap: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var region: MKCoordinateRegion
    
    init(location: CLLocation, span: MKCoordinateSpan) {
        self._region = State(initialValue: .init(
            center: location.coordinate,
            span: span
        ))
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Map(coordinateRegion: $region, interactionModes: .all)
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.largeTitle)
                    .symbolRenderingMode(.monochrome)
                    .foregroundColor(.secondary)
            }
            .padding(.top, 40)
            .padding(.trailing)
        }.ignoresSafeArea()
    }
}

struct FullScreenMap_Previews: PreviewProvider {
    static var previews: some View {
        FullScreenMap(
            location: Country.italy.location,
            span: Country.italy.span
        )
    }
}
