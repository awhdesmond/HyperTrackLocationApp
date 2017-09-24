//
//  MapViewController.swift
//  locationApp
//
//  Created by Ang Wei Hao Desmond on 23/9/17.
//  Copyright © 2017 desmond.ang.a0093896H. All rights reserved.
//

import UIKit
import HyperTrack

class MapViewController: UIViewController, HTViewInteractionDelegate, HTEventsDelegate {

    // Instantiate HyperTrack map view and embed this in your view
    let hyperTrackMap = HyperTrack.map()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        // Configure view interaction delegate in HyperTrack map
        hyperTrackMap.setHTViewInteractionDelegate(interactionDelegate: self)
        // Configure view customization delegate in HyperTrack map
        hyperTrackMap.setHTViewCustomizationDelegate(customizationDelegate: self)
        // Configure events delegate in HyperTrack map
        HyperTrack.setEventsDelegate(eventDelegate: self)
        hyperTrackMap.embedIn(self.view)
    }
}

//HTViewCustomizationDelegate
extension MapViewController: HTViewCustomizationDelegate {
    @objc func showBackButton(map: HTMap) -> Bool {
        return false
    }

    @objc func showReFocusButton(map: HTMap) -> Bool {
        return false
    }
}
