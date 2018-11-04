//
//  ViewControllerHome.swift
//  userLocation
//
//  Created by Anna Chang on 11/4/18.
//  Copyright © 2018 Anna Chang. All rights reserved.
//

import UIKit
import CoreLocation

class ViewControllerHome: UIViewController {

    @IBOutlet weak var text: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tappedGo(_ sender: Any) {
        performSegue(withIdentifier: "ToMapView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier,
            identifier == "ToMapView",
            let fullCoor = text.text,
            let destination = segue.destination as? ViewController {
            
            var x: Double = 0
            var y: Double = 0
            
            for i in 0..<fullCoor.count {
                let currentIndex = fullCoor.index(fullCoor.startIndex, offsetBy: i)
                
                if fullCoor[currentIndex] == "," {
                    x = Double(fullCoor[fullCoor.startIndex..<currentIndex])!
                    
                    let nextIndex = fullCoor.index(after: currentIndex)
                    let nextNextIndex = fullCoor.index(after: nextIndex)
                    y = Double(fullCoor[nextNextIndex..<fullCoor.endIndex])!
                }
            }

            destination.myCoordinates = CLLocationCoordinate2D(latitude: x, longitude: y)
        }
    }

}
