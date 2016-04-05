//
//  MensajesViewController.swift
//  Catalogo
//
//  Created by Nora Hilda De los Reyes on 30/03/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class MensajesViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var nombreTextField: UITextField!
    
    @IBOutlet weak var fechaTextFiled: UITextField!
    
    @IBOutlet weak var mensajeTextView: UITextView!
    
    var user: PFUser!
    
    let date: NSDate = NSDate(timeIntervalSinceNow: 0)
    
    var mensajeEnviado: Bool = false
    
    @IBOutlet weak var enviarButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        print(date)
        print(PFUser.currentUser())
        
        nombreTextField.text = PFUser.currentUser()?.username!
        fechaTextFiled.text = date.description
        
        mensajeTextView.clearsOnInsertion = true
        //mensajeEnviado = false
    
    }
    
    override func viewDidAppear(animated: Bool) {
        
        mensajeTextView.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func enviarTapped(sender: UIButton) {
        
        if mensajeEnviado == false {
            
        
            let mensaje = PFObject(className: "Mensajes")
            
            mensaje["mensajeDescripcion"] = mensajeTextView.text
            mensaje["usuarioDelMensaje"] = PFUser.currentUser()
            
            mensaje.saveInBackgroundWithBlock {
                
                (saved: Bool, error: NSError?) -> Void in
                
                if saved {
                    
                    self.displayError("Completo", message: "El mensaje ha sido enviado. Toca cancelar para regresar.")
                    print("saved the menssage to parse")
                    
                    //self.dismissViewControllerAnimated(true, completion: nil)
                    
                    self.mensajeTextView.userInteractionEnabled = false
                    
                    self.dismissViewControllerAnimated(true, completion: nil)
                    
                    self.enviarButton.enabled = false
                    
                } else {
                    
                    print(error?.localizedDescription)
                    self.displayError("Error", message: "Hubo un error al mandar el mensaje, intentalo de nuevo.")
                }
                
            }
        mensajeEnviado = true
            
        } else {
           
            enviarButton.enabled = false
            
        }
        
        
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
    
    //Textfield things
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        nombreTextField.resignFirstResponder()
        fechaTextFiled.resignFirstResponder()
        mensajeTextView.resignFirstResponder()
    }
  func displayError(title: String, message: String) {
        
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
