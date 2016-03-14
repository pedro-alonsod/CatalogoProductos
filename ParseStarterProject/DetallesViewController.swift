//
//  DetallesViewController.swift
//  Catalogo
//
//  Created by Nora Hilda De los Reyes on 14/03/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class DetallesViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    @IBOutlet weak var productoImageView: UIImageView!
    @IBOutlet weak var nombreProductoText: UITextField!
    @IBOutlet weak var ProductoPrecioText: UITextField!
    @IBOutlet weak var ProductoCantidadText: UITextField!
    
    @IBOutlet weak var ProductoDescripcionText: UITextView!
    
    var imagePicker: UIImagePickerController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func guardarTapped(sender: UIButton) {
    
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)

    
    }

    @IBAction func cancelarTapped(sender: UIButton) {
    
    
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    /*
    @IBAction func takePhoto(sender: UIButton) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    */
    
     func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        productoImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        nombreProductoText.resignFirstResponder()
        ProductoPrecioText.resignFirstResponder()
        ProductoDescripcionText.resignFirstResponder()
        ProductoDescripcionText.resignFirstResponder()
    }
}
