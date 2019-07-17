//
//  ScoreViewController.swift
//  morpion
//
//  Created by Benjamin Courtine on 21/06/2019.
//  Copyright © 2019 Ben. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setScore()
        print("bob")
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var user1Win: UILabel!
    @IBOutlet weak var user2Win: UILabel!
    @IBOutlet weak var egality: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setScore()
    }
    
    func setScore() {
        let userDefaults = UserDefaults.standard
        let numOfWinUser1 = userDefaults.integer(forKey: "user1") as Int
        let numOfWinUser2 = userDefaults.integer(forKey: "user2") as Int
        let numOfEgality = userDefaults.integer(forKey: "egality") as Int
        
        user1Win.text = "Victoires du user1: " + String(numOfWinUser1)
        user2Win.text = "Victoires du user2: " + String(numOfWinUser2)
        egality.text = "Égalitées: " + String(numOfEgality)
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
