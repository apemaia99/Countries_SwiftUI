//
//  CLLocationCoordinate2D+Equatable.swift
//  Countries
//
//  Created by Alessandro Di Maio on 26/09/22.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
