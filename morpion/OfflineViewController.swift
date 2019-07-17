//
//  OfflineViewController.swift
//  morpion
//
//  Created by Benjamin Courtine on 18/06/2019.
//  Copyright © 2019 Ben. All rights reserved.
//

import UIKit
import SocketIO

class OfflineViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //label
    @IBOutlet weak var playerTurn: UILabel!
    //Buttons

    var turn = 1
    var cases = ["", "", "", "", "", "", "", "", ""]
    var victory = false
    var egality = false
    var allVictories = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9],
        [1, 4, 7],
        [2, 5, 8],
        [3, 6, 9],
        [1, 5, 9],
        [3, 5, 7],
    ]
    
    func isWin() {
        let userDefaults = UserDefaults.standard
        for (i, _) in allVictories.enumerated() {
            var values: [String?] = []
            for j in allVictories[i] {
                values.append(cases[j-1])
            }
            if (values[0]?.count != 0 && values[1]?.count != 0 && values[2]?.count != 0 && values[0] == values[1] && values[0] == values[2]) {
                victory = true
                let numOfWin = userDefaults.integer(forKey: values[0]!) as Int
                userDefaults.set(numOfWin + 1, forKey: values[0]!)
                
                if (userDefaults.array(forKey: "localHistory") == nil) {
                    let test = ["Victoire de " + values[0]!]
                    userDefaults.set(test, forKey: "localHistory")
                } else {
                    var arrHistory = [Any]()
                    for i in userDefaults.array(forKey: "localHistory")! {
                        arrHistory.append(i)
                    }
                    arrHistory.append("Victoire de " + values[0]!)
                    userDefaults.set(arrHistory, forKey: "localHistory")
                }
                
                playerTurn.text = "Victoire du " + values[0]!
            } else if (turn == 10 && !victory && !egality && i == allVictories.count - 1) {
                egality = true
                let numOfEgality = userDefaults.integer(forKey: "egality") as Int
                userDefaults.set(numOfEgality + 1, forKey: "egality")

                if (userDefaults.array(forKey: "localHistory") == nil) {
                    let test = ["Égalitée"]
                    userDefaults.set(test, forKey: "localHistory")
                } else {
                    var arrHistory = [Any]()
                    for i in userDefaults.array(forKey: "localHistory")! {
                        arrHistory.append(i)
                    }
                    arrHistory.append("Égalitée")
                    userDefaults.set(arrHistory, forKey: "localHistory")
                }

                playerTurn.text = "Égalité..."
            }
        }
    }
    
    func chooseImg() -> String {
        let imgPlayer1 = "circle.jpg"
        let imgPlayer2 = "cross.jpg"
        if (turn % 2 == 0) {
            return imgPlayer2
        } else {
            return imgPlayer1
        }
    }
    
    func checkUser() -> String {
        if (turn % 2 == 0) {
            return "user2"
        } else {
            return "user1"
        }
    }
    
    @IBAction func btn(_ sender: UIButton) {
        if victory == false && egality == false {
            if sender.imageView?.image == nil {
                cases[sender.tag-1] = checkUser()
                sender.setImage(UIImage(named: chooseImg())?.withRenderingMode(.alwaysOriginal), for: .normal)
                turn += 1
                if (turn % 2 == 0) {
                    playerTurn.text = "Au joueur 2 de jouer"
                } else {
                    playerTurn.text = "Au joueur 1 de jouer"
                }
                
                sender.isUserInteractionEnabled = false
            }
            isWin()
        }
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
