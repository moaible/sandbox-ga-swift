//
//  ViewController.swift
//  SandboxGA
//
//  Created by Hiromi Motodera on 12/12/17.
//  Copyright © 2017 moaible. All rights reserved.
//

import UIKit

struct Tracker: GoogleAnalyticsSendable {
    
    static var googleAnalyticsTrackingId: String {
        return ""
    }
}

class SomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
}
