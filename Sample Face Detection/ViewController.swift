//
//  ViewController.swift
//  Sample Face Detection
//
//  Created by karthick kck on 24/01/2020.
//  Copyright © 2020 karthick kck. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("ViewController")
    }

    @IBAction func authenticateTapped(_ sender: Any) {
        
        let context = LAContext()
                
        var error: NSError?
         
         if context.canEvaluatePolicy(
                LAPolicy.deviceOwnerAuthenticationWithBiometrics,
                error: &error) {
                        
                // Device can use biometric authentication
                context.evaluatePolicy(
                    LAPolicy.deviceOwnerAuthenticationWithBiometrics,
                    localizedReason: "Access requires authentication",
                    reply: {(success, error) in
                        DispatchQueue.main.async {
                            
                            if let err = error {
                                
                                switch err._code {
                                    
                                case LAError.Code.systemCancel.rawValue:
                                    self.notifyUser("Session cancelled",
                                                    err: err.localizedDescription)
                                    
                                case LAError.Code.userCancel.rawValue:
                                    self.notifyUser("Please try again",
                                                    err: err.localizedDescription)
                                    
                                case LAError.Code.userFallback.rawValue:
                                    self.notifyUser("Authentication",
                                                    err: "Password option selected")
                                    // Custom code to obtain password here
                                    
                                default:
                                    self.notifyUser("Authentication failed",
                                                    err: err.localizedDescription)
                                }
                                
                            } else {
                                self.notifyUser("Authentication Successful",
                                                err: "You now have full access")
                            }
                        }
                })

            } else {
                // Device cannot use biometric authentication
                if let err = error {
                    switch err.code {
                        
                    case LAError.Code.biometryNotEnrolled.rawValue:
                        notifyUser("User is not enrolled",
                                   err: err.localizedDescription)
                        
                    case LAError.Code.passcodeNotSet.rawValue:
                        notifyUser("A passcode has not been set",
                                   err: err.localizedDescription)
                        
                        
                    case LAError.Code.biometryNotAvailable.rawValue:
                        notifyUser("Biometric authentication not available",
                                   err: err.localizedDescription)
                    default:
                        notifyUser("Unknown error",
                                   err: err.localizedDescription)
                    }
                }
            }
       
        
       /* if context.canEvaluatePolicy(
            LAPolicy.deviceOwnerAuthenticationWithBiometrics,
                 error: &error) {
                    
            if (context.biometryType == LABiometryType.faceID) {
                // Device support Face ID
            } else if context.biometryType == LABiometryType.touchID {
                // Device supports Touch ID
                context.evaluatePolicy(
                  LAPolicy.deviceOwnerAuthenticationWithBiometrics,
                  localizedReason: "Authentication is required for access",
                  reply: {(success, error) in
                      // Code to handle reply here
                })
                
            } else {
                // Device has no biometric support
            }
        }*/
        
      /*  let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, authenticationError in

                DispatchQueue.main.async {
                    if success {
                        //self?.unlockSecretMessage()
                        print("MEssage")
                    } else {
                        // error
                        print("error")
                    }
                }
            }
        } else {
            // no biometry
            print("no biometry")
        }*/

    }
        func notifyUser(_ msg: String, err: String?) {
            let alert = UIAlertController(title: msg,
                message: err,
                preferredStyle: .alert)

            let cancelAction = UIAlertAction(title: "OK",
                style: .cancel, handler: nil)

            alert.addAction(cancelAction)

            self.present(alert, animated: true,
                                completion: nil)
        }

}

