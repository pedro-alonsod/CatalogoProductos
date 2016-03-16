//
//  DetallesViewController.swift
//  Catalogo
//
//  Created by Nora Hilda De los Reyes on 14/03/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class DetallesViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    @IBOutlet weak var productoImageView: UIImageView!
    @IBOutlet weak var nombreProductoText: UITextField!
    @IBOutlet weak var ProductoPrecioText: UITextField!
    @IBOutlet weak var ProductoCantidadText: UITextField!
    
    var productoNombre: String!
    var productoDescripcion: String!
    var productoCantided: String!
    var productoPrecio: String!
    var productoObjectId: String?
    
    @IBOutlet weak var ProductoDescripcionText: UITextView!
    
    var imagePicker: UIImagePickerController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        nombreProductoText.text = productoNombre
        ProductoCantidadText.text = productoCantided
        nombreProductoText.text = productoNombre
        ProductoDescripcionText.text = "Descripcion: \(productoDescripcion)"
        ProductoPrecioText.text = productoPrecio
        print(productoObjectId)
        
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
    
    
    @IBAction func saveTapped(sender: UIButton) {
        
        if ProductoDescripcionText.text != "" && ProductoPrecioText.text != "" &&  ProductoCantidadText.text != "" && productoImageView.image != nil && productoObjectId == nil {
            
            let pNombre = nombreProductoText.text
            let pPrecio = ProductoPrecioText.text
            let pCantidad = ProductoCantidadText.text
            let pDescripcion = ProductoDescripcionText.text
            
            
            let pickedImage:UIImage = productoImageView.image!
            //let scaledImage = scaleImageWith(pickedImage)
            let imageData = UIImageJPEGRepresentation(pickedImage, 0.5)
            let imageFile:PFFile = PFFile(data: imageData!)!
            
            
            var objectToParse = PFObject(className: "Producto")
            
            objectToParse["nombre"] = pNombre
            objectToParse["cantidad"] = pCantidad
            objectToParse["precio"] = pPrecio
            objectToParse["descripcion"] = pDescripcion
            objectToParse["pedir"] = false
            //objectToParse["Foto"] = PFFile(data: imageData!)
            objectToParse.setObject(imageFile, forKey: "Foto")
            
            objectToParse.saveInBackgroundWithBlock {
                
                (success: Bool, error: NSError?) -> Void in
                
                if success {
                    
                    print("saved success")
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    
                    print(error?.description)
                }
            }
        } else if productoObjectId != nil {
            
            let pNombre = nombreProductoText.text
            let pPrecio = ProductoPrecioText.text
            let pCantidad = ProductoCantidadText.text
            let pDescripcion = ProductoDescripcionText.text
            
            
            let pickedImage:UIImage = productoImageView.image!
            //let scaledImage = scaleImageWith(pickedImage)
            let imageData = UIImageJPEGRepresentation(pickedImage, 0.5)
            let imageFile:PFFile = PFFile(data: imageData!)!
            

            let updateQuery = PFQuery(className: "Producto")
            
            updateQuery.getObjectInBackgroundWithId(productoObjectId!) {
                
                (object: PFObject?, error: NSError?) -> Void in
                
                if error == nil {
                    
                    object!["nombre"] = pNombre
                    object!["cantidad"] = pCantidad
                    object!["precio"] = pPrecio
                    object!["descripcion"] = pDescripcion
                    object!["pedir"] = false
                    //objectToParse["Foto"] = PFFile(data: imageData!)
                    //object!.setObject(imageFile, forKey: "Foto")
                    
                    object!.saveInBackgroundWithBlock {
                        
                        (success: Bool?, error: NSError?) -> Void in
                        
                        if error == nil {
                            
                            print("updated inside")
                            self.dismissViewControllerAnimated(true, completion: nil)
                            
                            
                        } else {
                            
                            print(error?.description)
                        }
                    }
                    
                } else {
                    
                    
                }
            }
            
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        nombreProductoText.resignFirstResponder()
        ProductoPrecioText.resignFirstResponder()
        ProductoDescripcionText.resignFirstResponder()
        ProductoCantidadText.resignFirstResponder()
    }
}
