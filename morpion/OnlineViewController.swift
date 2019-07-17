//
//  OnlineViewController.swift
//  morpion
//
//  Created by Benjamin Courtine on 28/06/2019.
//  Copyright © 2019 Ben. All rights reserved.
//

import UIKit

class OnlineViewController: UIViewController {

    let socketManager = SocketWrapper.shared

    @IBOutlet weak var playerXLabel: UILabel!
    @IBOutlet weak var playerOLabel: UILabel!
    @IBOutlet weak var currentTurnLabel: UILabel!
    @IBOutlet weak var viictoryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerXLabel.text = "Player X: " + self.playerX
        playerXLabel.textAlignment = .center
        playerOLabel.text = "Player O: " + self.playerO
        playerOLabel.textAlignment = .center
        viictoryLabel.textAlignment = .center
        currentTurnLabel.text = "Current turn: " + currentUserTurn()
        currentTurnLabel.textAlignment = .center
        var numberOfTurn = 0
        
        socketManager.socket.on("movement") {data, ack in
            var json = data as! [[String: Any]]
            print("------------------------")
            print(json[0])
            print("playerO: " + self.playerO)
            print("playerX: " + self.playerX)
            print("currentTurn: " + self.currentTurn)
            print(numberOfTurn)
            print("------------------------")
            
            
            if (json[0]["err"] as? String) != nil {
                // ERROR
            } else {
                numberOfTurn += 1
                let index : Int = json[0]["index"] as! Int
                let btn = self.view.viewWithTag(index+1) as? UIButton
                
                btn!.setImage(UIImage(named: self.chooseImg())?.withRenderingMode(.alwaysOriginal), for: .normal)
                
                self.currentTurn = json[0]["player_play"] as! String
                self.currentTurnLabel.text = "Current turn: " + self.currentUserTurn()
                btn?.isUserInteractionEnabled = false
            }
            
            if (numberOfTurn == 9 && (json[0]["err"] as? String) == nil && (json[0]["win"]) as! Int == 0) {
                self.playerXLabel.text = ""
                self.playerOLabel.text = ""
                self.currentTurnLabel.text = ""
                self.viictoryLabel.text = "Egality"
            }
            
            if ((json[0]["err"] as? String) == nil && (json[0]["win"]) as! Int == 1) {
                var winner = ""
                self.playerXLabel.text = ""
                self.playerOLabel.text = ""
                self.currentTurnLabel.text = ""
                if (self.currentTurn == "o") {
                    winner = self.playerX
                } else {
                    winner = self.playerO
                }
                self.viictoryLabel.text = self.whoWin(winner: winner)
            }
        }
    }
    
    var gameData : [[String: Any?]]?
    var me : String = ""
    var playerO : String = ""
    var playerX : String = ""
    var currentTurn : String = ""
    
    @IBAction func play(_ sender: UIButton) {
        socketManager.socket.emit("movement", sender.tag-1)
    }

    
    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func chooseImg() -> String {
        let imgPlayer1 = "circle.jpg"
        let imgPlayer2 = "cross.jpg"
        if (currentTurn == "x") {
            return imgPlayer2
        } else {
            return imgPlayer1
        }
    }
    
    func currentUserTurn()-> String {
        if (currentTurn == "o") {
            return playerO
        } else {
            return playerX
        }
    }
    
    func whoWin(winner: String)-> String {
        if (winner == me) {
            return "Victory"
        } else {
            return "Defeat"
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
