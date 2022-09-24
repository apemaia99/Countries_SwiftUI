//
//  Country+Error.swift
//  Countries
//
//  Created by Alessandro Di Maio on 23/09/22.
//

import Foundation
extension Country {
    enum Errors: Error {
        case missingKey(String)
        case notImplemented
    }
}
