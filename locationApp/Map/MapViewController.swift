//
//  MapViewController.swift
//  locationApp
//
//  Created by Ang Wei Hao Desmond on 23/9/17.
//  Copyright © 2017 desmond.ang.a0093896H. All rights reserved.
//

import UIKit
import HyperTrack
import WebKit

class MapViewController: UIViewController, HTViewInteractionDelegate, HTEventsDelegate {
    var webView : WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        UIApplication.shared.open(URL(string:"https://dashboard.hypertrack.com/map/users?ordering=-last_heartbeat_at")!, options: ["UserAgent" : "Chrome Safari"], completionHandler: nil)
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
