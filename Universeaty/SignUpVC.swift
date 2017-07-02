//
//  SignUpVC.swift
//  Universeaty
//
//  Created by Mark Endo on 6/20/17.
//  Copyright © 2017 Mark Endo. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpButton.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignUpPressed(sender: UIButton!) {
        if let name = nameTextField.text, name != "", let email = emailTextField.text, email != "", let pwd = passwordTextField.text, pwd != "" {
            
            Auth.auth().createUser(withEmail: email, password: pwd) { (user, error) in
            
                if error != nil {
                    print(error.debugDescription)
                    self.showErrorAlert(title: "Could not create account", msg: "Try again later")
                } else if user != nil {
                    UserDefaults.standard.setValue(user!.uid, forKey: "uid")
                    UserDefaults.standard.setValue(name, forKey: "name")

                    Auth.auth().signIn(withEmail: email, password: pwd) { (user, err)  in
                        
                        let userInfo: Dictionary<String, String> = [
                            "name": name
                        ]
                        
                        Database.database().reference().child("all users").child(user!.uid).setValue(userInfo)
                    }
                    self.performSegue(withIdentifier: "signUpToHome", sender: nil)
                }
            }
        }
    }
    
    func showErrorAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func onBackPressed(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.3)
            UIView.setAnimationBeginsFromCurrentState(true)
            view.frame = CGRect(x: CGFloat(view.frame.origin.x), y: CGFloat(view.frame.origin.y - 55.0), width: CGFloat(view.frame.size.width), height: CGFloat(view.frame.size.height))
            UIView.commitAnimations()
        } else if textField == passwordTextField {
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.3)
            UIView.setAnimationBeginsFromCurrentState(true)
            view.frame = CGRect(x: CGFloat(view.frame.origin.x), y: CGFloat(view.frame.origin.y - 105.0), width: CGFloat(view.frame.size.width), height: CGFloat(view.frame.size.height))
            UIView.commitAnimations()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.3)
            UIView.setAnimationBeginsFromCurrentState(true)
            view.frame = CGRect(x: CGFloat(view.frame.origin.x), y: CGFloat(view.frame.origin.y + 55.0), width: CGFloat(view.frame.size.width), height: CGFloat(view.frame.size.height))
            UIView.commitAnimations()
        } else if textField == passwordTextField {
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.3)
            UIView.setAnimationBeginsFromCurrentState(true)
            view.frame = CGRect(x: CGFloat(view.frame.origin.x), y: CGFloat(view.frame.origin.y + 105.0), width: CGFloat(view.frame.size.width), height: CGFloat(view.frame.size.height))
            UIView.commitAnimations()
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            nameTextField.resignFirstResponder()
            emailTextField.becomeFirstResponder()
        } else  if textField == emailTextField {
            emailTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else {
            passwordTextField.resignFirstResponder()
        }
        
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
