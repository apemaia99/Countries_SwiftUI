//
//  Country+Capital.swift
//  Countries
//
//  Created by Alessandro Di Maio on 23/09/22.
//

import Foundation
import CoreLocation

extension Country {
    struct Capital: Decodable {
        
        let name: String
        let location: CLLocation
        
        init(name: String, location: CLLocation) {
            self.name = name
            self.location = location
        }
        
        init(from decoder: Decoder) throws {
            
            let root = try decoder.container(keyedBy: CodingKeys.self)
            
            do {
                name = try root
                    .decode([String].self, forKey: .name)
                    .first ?? ""
            } catch {
                throw Errors.missingKey("capital")
            }
            
            do {
                let latlng = try root
                    .nestedContainer(keyedBy: AdditionalInfoKeys.self, forKey: .location)
                    .decode([CLLocationDegrees].self, forKey: .latlng)
                
                location = .init(latitude: latlng[0], longitude: latlng[1])
            } catch {
                throw Errors.missingKey("capitalInfo-latlng")
            }
        }
        
        enum CodingKeys: String, CodingKey {
            case name = "capital"
            case location = "capitalInfo"
        }
        
        enum AdditionalInfoKeys: String, CodingKey {
            case latlng = "latlng"
        }
    }
}
