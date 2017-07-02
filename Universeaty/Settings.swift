//
//  Settings.swift
//  Universeaty
//
//  Created by Rushil Kapadia on 6/27/17.
//  Copyright © 2017 Mark Endo. All rights reserved.
//

import UIKit

class Settings: UIViewController {
    @IBOutlet weak var Name: UILabel!
    
    //var post: Post!
    
    @IBOutlet weak var Edit: UIButton!
    @IBOutlet weak var logOut: UIButton!
    
    @IBOutlet weak var email: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        logOut.layer.cornerRadius = 3
        Edit.layer.cornerRadius = 3
        Name.text = UserDefaults.standard.value(forKey: "name") as? String
        //email.text = UserDefaults.standard.value(forKey: "") as? String
    }

    @IBAction func onBackPressed(_ sender: Any) {

        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOut(_ sender: Any) {
    
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.present(loginVC, animated: false, completion: {
            })
        
        

    }
    
}
