//
//  WheelViewController.swift
//  WingIt
//
//  Created by Jonah Zukosky on 9/25/18.
//  Copyright © 2018 Zukosky, Jonah. All rights reserved.
//

import UIKit

class WheelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var restaurants = [String]()
    var chosenWing = ""
    @IBOutlet weak var restaurantTableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var wingItButton: UIButton!
    
    var superWingToggle = false
    let superWingItAlert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertController.Style.alert)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantTableView.delegate = self
        restaurantTableView.dataSource = self
        
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longButtonPress))
//        let deepPressGestureRecognizer = UILongPressGestureRecognizer(target: self,
//                                                                    action: "deepPressHandler:",
//                                                                    threshold: 0.75)
        wingItButton.addGestureRecognizer(gestureRecognizer)
        
        
        
        superWingItAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
    }
    
    
    @objc func longButtonPress() {
//        if superWingToggle {
//            wingItButton.backgroundColor = UIColor(red:0.22, green:0.40, blue:0.92, alpha:1.0)
//            wingItButton.titleLabel?.text = "WingIt!"
//            superWingToggle = false
//        } else {
//            wingItButton.backgroundColor = UIColor.red
//            wingItButton.titleLabel?.text = "Super WingIt!"
//            superWingToggle = true
            self.present(superWingItAlert, animated: true, completion: nil)
//        }
    }
    @IBAction func textFieldDidEndEditing(_ sender: Any) {
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        guard let restaurant = textField.text else {
            textField.resignFirstResponder()
            return
        }
        
        restaurants.append(restaurant)
        textField.text = ""
        textField.resignFirstResponder()
        restaurantTableView.reloadData()
    }
    
    @IBAction func wingingIt(_ sender: Any) {
        if restaurants.count != 0 {
            chosenWing = restaurants[Int.random(in: 0..<restaurants.count)]
            performSegue(withIdentifier: "wingSegue", sender: nil)
        }
        
    }
    
    // MARK: - Tableview
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath)
        
        cell.textLabel?.text = restaurants[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Current Restaurants"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            self.restaurants.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if #available(iOS 9.0, *) {
                if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
                    
                    if touch.force == touch.maximumPossibleForce && touch.view == wingItButton {
                        textField.text = "FORCED"
                    }
                }
            }
        }
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let destination = segue.destination as! WingedViewController
        
        destination.wingText = chosenWing
    }
 

}
