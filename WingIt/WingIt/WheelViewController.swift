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
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantTableView.delegate = self
        restaurantTableView.dataSource = self
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
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let destination = segue.destination as! WingedViewController
        
        destination.wingText = chosenWing
    }
 

}
