//
//  Layout.swift
//  GOGOXCodeChallenge
//
//  Created by ho yin Chan on 8/10/2021.
//

import UIKit
import WayPointJourney

class Layout: Layouting {
    let fontLayout: FontLayouting
    let colorLayout: ColorLayouting

    init(
        fontLayout: FontLayouting = FontLayout(),
        colorLayout: ColorLayouting = ColorLayout()) {
        self.fontLayout = fontLayout
        self.colorLayout = colorLayout
    }
}
