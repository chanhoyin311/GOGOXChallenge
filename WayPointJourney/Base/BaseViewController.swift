//
//  BaseViewController.swift
//  WayPointJourney
//
//  Created by ho yin Chan on 8/10/2021.
//

import UIKit

public class BaseViewController: UIViewController {
    let configuration: Configurable
    
    init(
        configuration: Configurable
    ) {
        self.configuration = configuration
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = configuration.layout.colorLayout.white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
