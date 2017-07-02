//
//  LoginVC.swift
//  Universeaty
//
//  Created by Mark Endo on 6/20/17.
//  Copyright © 2017 Mark Endo. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInButton.layer.cornerRadius = 5
        signUpButton.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginPressed(sender: UIButton!) {
        if let email = emailTextField.text, email != "", let pwd = passwordTextField.text, pwd != "" {
            
            Auth.auth().signIn(withEmail: email, password: pwd) { (user, error) in
                if error != nil {
                    if error!._code == 17008 || error!._code == 17009 {
                        self.showErrorAlert(title: "Not a registered account", msg: "email or password is incorrect")
                    } else {
                        self.showErrorAlert(title: "Not able to login", msg: "try again later")
                        print(error!._code)
                    }
                } else if user != nil {
                    //maybe create loading circle
                    
                    UserDefaults.standard.setValue(user!.uid, forKey: "uid")
                    print(user!.uid)
                    Database.database().reference().child("all users").child(user!.uid).observe(.value, with: { snapshot in
                        if let userInfo = snapshot.value as? Dictionary<String, String> {
                            let name = userInfo["name"]
                            UserDefaults.standard.setValue(name, forKey: "name")
                            //put in information here
                            self.performSegue(withIdentifier: "goToHome", sender: nil)
                        }
                    })
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
    
    @IBAction func onSignUpPressed(sender: UIButton!) {
        self.performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == passwordTextField {
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.3)
            UIView.setAnimationBeginsFromCurrentState(true)
            view.frame = CGRect(x: CGFloat(view.frame.origin.x), y: CGFloat(view.frame.origin.y - 55.0), width: CGFloat(view.frame.size.width), height: CGFloat(view.frame.size.height))
            UIView.commitAnimations()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == passwordTextField {
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.3)
            UIView.setAnimationBeginsFromCurrentState(true)
            view.frame = CGRect(x: CGFloat(view.frame.origin.x), y: CGFloat(view.frame.origin.y + 55.0), width: CGFloat(view.frame.size.width), height: CGFloat(view.frame.size.height))
            UIView.commitAnimations()
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
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
