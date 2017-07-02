//
//  Settings.swift
//  Universeaty
//
//  Created by Rushil Kapadia on 6/27/17.
//  Copyright © 2017 Mark Endo. All rights reserved.
//

import UIKit
import Firebase


class ChangeName: UIViewController, UITextFieldDelegate{
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var changeName: UIButton!
    
    var post: Post!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameText.delegate = self;
        // Do any additional setup after loading the view, typically from a nib.
        changeName.layer.cornerRadius = 3
        nameText.text = UserDefaults.standard.value(forKey: "name") as? String

    }
    
    @IBAction func onBackPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeName(_ sender: Any) {
        UserDefaults.standard.setValue(nameText.text, forKey: "name")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    
}
