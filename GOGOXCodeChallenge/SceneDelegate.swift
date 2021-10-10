//
//  SceneDelegate.swift
//  GOGOXCodeChallenge
//
//  Created by ho yin Chan on 8/10/2021.
//

import UIKit
import WayPointJourney

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let configuration = WayPointConfiguration(
            apiClient: Constant.isStubJson ? StubAPIClient() : RealAPIClient()
        )
        guard let scence = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scence)
        let entryController = JourneyFactory.makeWayPointViewController(
            configuration: configuration
        )
        let navigationController = UINavigationController(
            rootViewController: entryController
        )
        window.makeKeyAndVisible()
        window.rootViewController = navigationController
        self.window = window
    }
}

