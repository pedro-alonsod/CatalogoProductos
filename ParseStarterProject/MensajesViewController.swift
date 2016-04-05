//
//  MensajesViewController.swift
//  Catalogo
//
//  Created by Nora Hilda De los Reyes on 30/03/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class MensajesViewController: UIViewController {

    
    @IBOutlet weak var nombreTextField: UITextField!
    
    @IBOutlet weak var fechaTextFiled: UITextField!
    
    @IBOutlet weak var mensajeTextView: UITextView!
    
    var user: PFUser!
    
    let date: NSDate = NSDate(timeIntervalSinceNow: 0)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func enviarTapped(sender: UIButton) {
    }

    @IBAction func cancelarTapped(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
