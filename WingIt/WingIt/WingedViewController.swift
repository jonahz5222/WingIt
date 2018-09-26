//
//  WingedViewController.swift
//  WingIt
//
//  Created by Jonah Zukosky on 9/25/18.
//  Copyright © 2018 Zukosky, Jonah. All rights reserved.
//

import UIKit
import MapKit

class WingedViewController: UIViewController {

    @IBOutlet weak var wingLabel: UILabel!
    var wingText = ""
    let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wingLabel.text = wingText

        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismissWinging(_ sender: Any) {
        dismiss(animated: true,completion: nil)
    }
    
    @IBAction func navigate(_ sender: Any) {
        let geocoder = CLGeocoder()
        guard let location = wingLabel.text else {return}
        geocoder.geocodeAddressString(location) { (placemarksOptional, error) -> Void in
            if let placemarks = placemarksOptional {
                print("placemark| \(String(describing: placemarks.first))")
                if let location = placemarks.first?.location {
//                    let query = "?ll=\(location.coordinate.latitude),\(location.coordinate.longitude)"
//                    let path = "http://maps.apple.com/" + query
//                    if let url = URL(string: path) {
//                        UIApplication.shared.openURL(url)
//                        self.dismiss(animated: true, completion: nil)
//                    } else {
//
//                    }
                    
                    if let placemark = placemarks.first {
                        if let addressDict = placemark.addressDictionary {
                            let mkPlacemark = MKPlacemark(coordinate: location.coordinate, addressDictionary: addressDict as! [String : Any])
                            let mapItem = MKMapItem(placemark: mkPlacemark)
                            mapItem.openInMaps(launchOptions: self.launchOptions)
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                    
                } else {
                    self.wingLabel.text = "You SUCK"
                    self.wingLabel.textColor = UIColor.red
                    self.wingLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
                    sleep(3)
                    self.dismiss(animated: true, completion: nil)
                    self.wingLabel.textColor = UIColor.black
                    self.wingLabel.font = UIFont().withSize(17.0)
                }
            } else {
                // Didn't get any placemarks. Handle error.
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
