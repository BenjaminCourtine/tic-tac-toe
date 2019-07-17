//
//  OnlineScoreViewController.swift
//  morpion
//
//  Created by Benjamin Courtine on 28/06/2019.
//  Copyright © 2019 Ben. All rights reserved.
//

import UIKit

class OnlineScoreViewController: UIViewController {

    let socketManager = SocketWrapper.shared
    @IBOutlet weak var chooseUrNameLable: UILabel!
    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var labelError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        chooseUrNameLable.textAlignment = .center
        labelError.textAlignment = .center
        textInput.placeholder = "Your name"
        // Do any additional setup after loading the view.
    }
    
    var data : [[String: Any]] = []
    var me : String = "bob"

    @IBAction func GoToTicTacToe(_ sender: Any) {
        if (textInput.text!.count > 0) {
            labelError.text = ""
            me = textInput.text!
            socketManager.socket.emit("join_queue", me)
            socketManager.socket.on("join_game") {data, ack in
                self.data = data as! [[String: Any]]
                
                self.performSegue(withIdentifier: "goToTicTacToe", sender: self )
            }
        } else {
            labelError.text = "Please enter a name"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! OnlineViewController
        destinationVC.gameData = self.data
        destinationVC.me = self.me
        destinationVC.playerO = self.data[0]["playerO"] as! String
        destinationVC.playerX = self.data[0]["playerX"] as! String
        destinationVC.currentTurn = self.data[0]["currentTurn"] as! String
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
