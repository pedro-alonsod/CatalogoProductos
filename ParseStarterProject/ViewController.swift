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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func entrarTapped(sender: UIButton) {
        
        if usernameTextField.text != "" && passwordText.text != "" {
            
            PFUser.logInWithUsernameInBackground(usernameTextField.text!, password: passwordText.text!) {
                
                (userParse: PFUser?, error: NSError?) -> Void in
                
                if error != nil {
                    
                    print(" there was an error \(error?.description)")
                    
                } else {
                    
                    print("Logged in")
                    
                    self.performSegueWithIdentifier(self.productosSegue, sender: self)
                    
                }
            }
        }
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        usernameTextField.resignFirstResponder()
        passwordText.resignFirstResponder()
    }
}