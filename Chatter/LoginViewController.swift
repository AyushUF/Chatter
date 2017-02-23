//
//  LoginViewController.swift
//  Chatter
//
//  Created by Ayush Gupta on 2/22/17.
//  Copyright © 2017 Ayush Gupta. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var emailValue: UITextField!
    @IBOutlet weak var passwordValue: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        let user = PFUser()
        user.username = emailValue.text
        user.password = passwordValue.text
        user.email = emailValue.text
        
        user.signUpInBackground(block: { (succeeded: Bool, error: Error?) -> Void in
            if let error = error {
                let errorString = error.localizedDescription as? NSString
                // Show the errorString somewhere and let the user try again.
                
                self.displayAlert("Login Failed", message: (errorString as? String)!)
                
            } else {
                // Hooray! Let them use the app now.
                print("Sign up Success")
                self.performSegue(withIdentifier: "successfulLogin", sender: self)
            }
        })

    }
    
    @IBAction func onLogin(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: emailValue.text!, password: passwordValue.text!) {
            (user: PFUser?, error: Error?) -> Void in
            
            // self.activityIndicator.stopAnimating()
            // UIApplication.sharedApplication().endIgnoringInteractionEvents()
            
            if user != nil {
                // Do stuff after successful login.
                print("Login Success")
                self.performSegue(withIdentifier: "successfulLogin", sender: self)
                
                
            } else {
                // The login failed. Check error to see why.
                
                if let errorString = error!.localizedDescription as? String {
                    
                    self.displayAlert("Login Failed", message: errorString)
                }
            }
        }

    }
    
    
    func displayAlert(_ title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction((UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            self.dismiss(animated: true, completion: nil)
        })))
        
        self.present(alert, animated: true, completion: nil)
        
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
