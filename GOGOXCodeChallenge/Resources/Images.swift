//
//  Images.swift
//  GOGOXCodeChallenge
//
//  Created by ho yin Chan on 9/10/2021.
//

import UIKit

extension UIImage {
    enum AssetIdentifiers: String {
        case back = "back"
        case history = "history"
        case pickUp = "pickUp"
        case dropOff = "dropOff"
    }

    convenience init(assetIdentifier: AssetIdentifiers) {
        self.init(named: assetIdentifier.rawValue)!
    }
}
