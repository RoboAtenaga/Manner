//
//  ViewController.swift
//  Manner
//
//  Created by Robo Atenaga on 1/22/18.
//  Copyright © 2018 Robo Atenaga. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginWithFacebook(_ sender: UIButton) {
        handleCustomFBLogin()
    }
    
    func handleCustomFBLogin() {
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self) { (result, error) in
            if error != nil {
                print("Custom FB login failed: ", error as Any)
                return
            }
            self.getUserInformation()
            self.performSegue(withIdentifier: "segueToHome", sender: Any!.self)
        }
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil{
            print("FB login failed: ",error)
            return
        }
        getUserInformation()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Logout successful")
    }
    
    func getUserInformation(){
        // To get info of user, use FBSDKGraphRequest
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, error) in
            if error != nil {
                print("Failed to start graph request:", error as Any)
                return
            }
            // email isn't part of result because sometimes it requires permission
            print(result as Any)
        }
    }
}

