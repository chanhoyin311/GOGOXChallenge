//
//  Layouting.swift
//  WayPointJourney
//
//  Created by ho yin Chan on 8/10/2021.
//

import UIKit

public protocol Layouting {
    var fontLayout: FontLayouting { get }
    var colorLayout: ColorLayouting { get }
}

public protocol FontLayouting {
    var title1: UIFont { get }
    var title2: UIFont { get }
}

public protocol ColorLayouting {
    var textFieldBackgroundColor: UIColor { get }
    var separateLineColor: UIColor { get }
    var separateLineColor2: UIColor { get }
    var white: UIColor { get }
    var separateLineShadowColor: UIColor { get }
    var lightGrey: UIColor { get }
    var black: UIColor { get }
}
