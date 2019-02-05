//
//  ViewController.swift
//  GrandFam
//
//  Created by Filip Palmqvist on 2019-02-03.
//  Copyright © 2019 Filip Palmqvist. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // Outlets
    @IBOutlet weak var lableLabel: UILabel!
    @IBOutlet weak var testButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func testButtonTapped(_ sender: Any) {
        
        var user = WebApi.Select.GetUsers(cond: "WHERE user_id = 1")
        
        user[0].userName = "mrPaintMan"
        
        lableLabel.text = WebApi.Update.UpdateUser(user: user[0])
        
    }
    
}

