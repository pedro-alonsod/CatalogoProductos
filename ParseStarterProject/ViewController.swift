/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {

    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    var user: PFUser!
    
    let productosSegue = "ProductosSegue"
    let clientesSegue = "ClientesSegue"
    var segueToChoose: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //
    
    @IBAction func entrarTapped(sender: UIButton) {
        
        if usernameTextField.text != "" && passwordText.text != "" {
            
            PFUser.logInWithUsernameInBackground(usernameTextField.text!, password: passwordText.text!) {
                
                (userParse: PFUser?, error: NSError?) -> Void in
                
                if error != nil {
                    
                    print(" there was an error \(error?.description)")
                    
                } else {
                    
                    print("Logged in")
                    
                    let permission = userParse!["usuario"] as! Bool
                    
                    print(permission)
                    
                    if permission {
                    
                        self.performSegueWithIdentifier(self.clientesSegue, sender: self)
                        
                    } else {
                        
                        print("Moving to productos")
                    
                        self.performSegueWithIdentifier(self.productosSegue, sender: self)
                        
                        
                    }
                    
                    
                    
                }
            }
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
//        if segue.identifier == productosSegue {
//            
//            segueToChoose = productosSegue
//        } else {
//            
//            segueToChoose = clientesSegue
//        }
//        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        usernameTextField.resignFirstResponder()
        passwordText.resignFirstResponder()
    }
}
