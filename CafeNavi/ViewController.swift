//
//  ViewController.swift
//  CafeNavi
//
//  Created by 김진혁 on 2022/10/31.
//

import UIKit
import NMapsMap

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let mapView = NMFMapView(frame: view.frame)
        view.addSubview(mapView)
    }


}

