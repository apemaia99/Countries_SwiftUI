//
//  CLLocationCoordinate2D+Hashable.swift
//  Countries
//
//  Created by Alessandro Di Maio on 09/10/22.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.latitude)
        hasher.combine(self.longitude)
    }
}
