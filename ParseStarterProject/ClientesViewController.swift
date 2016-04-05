//
//  ClientesViewController.swift
//  Catalogo
//
//  Created by Nora Hilda De los Reyes on 18/03/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse
import MessageUI


class ClientesViewController: UIViewController, MFMailComposeViewControllerDelegate {

    
    var arrayProductos: [PFObject] = []
    
    var sortOrder = true
    
    let mensajesSegue = "MensajesSegue"

    
    
    @IBOutlet weak var productosTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let queryProductos = PFQuery(className: "Producto")
        
        do {
            
            arrayProductos = try queryProductos.findObjects()
        } catch let error {
            
            print(error)
        }
        
        print("this should print first \(arrayProductos.count)")
        print(arrayProductos[0].valueForKey("nombre")!)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("this second")
        return arrayProductos.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 1 {
            
            return "Productos"
            
        } else {
            
            
            return "Productos"
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let nombre = "nombre", foto = "Foto", descripcion = "descripcion", precio = "precio", cantidad =  "cantidad", pedir = "pedir"
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ClientesCell", forIndexPath: indexPath) as! ClientesTableViewCell
        
        
        if let pImg = arrayProductos[indexPath.row].valueForKey(foto) as? PFFile {
            
            
            do {
                
                pImg.getDataInBackgroundWithBlock {
                    
                    (data: NSData?, error: NSError?) -> Void in
                    
                    if error == nil {
                        
                        cell.imagenProducto.image = UIImage(data: data!)
                    }
                    
                }
            }
            
        }
        
        cell.nombreProducto.text = " \(arrayProductos[indexPath.row].valueForKey(nombre)!)"
        cell.descripcionProducto.text = "\(arrayProductos[indexPath.row].valueForKey(descripcion)!)"
        cell.precioProducto.text = "Precio: \(arrayProductos[indexPath.row].valueForKey(precio)!)"
        
        
        
        
        
        //cell.productoImg.image =
        
        return cell
        
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    
    
    // Override to support editing the table view.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            
            
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            
            //tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Right)
        }
    }
    
    
    
    // Override to support rearranging the table view.
    func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        
    }
    
    
    
    // Override to support conditional rearranging of the table view.
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let mensajesVC = segue.destinationViewController as! MensajesViewController
        
        mensajesVC.user = PFUser.currentUser()
        
    }

    
    @IBAction func salirTapped(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func mandarMensajeTapped(sender: UIButton) {
        
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["pedro.alonsod@gmail.com"])
        mailComposerVC.setSubject("Sending you an in-app e-mail...")
        mailComposerVC.setMessageBody("Productos", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func nombreTapped(sender: UIButton) {
        
        
        
        if sortOrder {
            
        
            arrayProductos.sortInPlace {
                (object1: PFObject, object2: PFObject) -> Bool in
                
                let o1 = object1["nombre"] as! String
                let o2 = object2["nombre"] as! String
                
                return o1 > o2
                
            }
            
            displayError("Alerta", message: "Re-acomodando productos.")

        
            productosTable.reloadData()
            
            sortOrder = false
            
            
        } else {
            
            
            arrayProductos.sortInPlace {
                
                (object1: PFObject, object2: PFObject) -> Bool in
                
                let o1 = object1["nombre"] as! String
                let o2 = object2["nombre"] as! String
                
                return o1 < o2
                
            }
            
            displayError("Alerta", message: "Re-acomodando productos.")

            
            productosTable.reloadData()
            
            sortOrder = true
            
        }
        
        
    }
    
    @IBAction func precioTapped(sender: UIButton) {
     
        if sortOrder {
            
            
            arrayProductos.sortInPlace {
                (object1: PFObject, object2: PFObject) -> Bool in
                
                let precio1String = object1["precio"] as! String
                let precio2String = object2["precio"] as! String
                
                print(precio1String)
                print(precio2String)
                
                let precio1 = Double(object1["precio"] as! String)!
                let precio2 = Double(object2["precio"] as! String)!
                
                print("precio1 \(precio1) precio2 \(precio2)")
                
                return (precio1 > precio2)
                
            }
            
            displayError("Alerta", message: "Re-acomodando productos.")

            
            productosTable.reloadData()
            
            sortOrder = false
            
            
        } else {
            
            
            arrayProductos.sortInPlace {
                
                (object1: PFObject, object2: PFObject) -> Bool in
                

                
                return (Double(object1["precio"] as! String)!) < (Double(object2["precio"] as! String)!)
            
            }
            
            displayError("Alerta", message: "Re-acomodando productos.")
            
            productosTable.reloadData()
            
            sortOrder = true
            
        }

        
    }
    
      func displayError(title: String, message: String) {
        
        if #available(iOS 8.0, *) {
            let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            
            
        } else {
            // Fallback on earlier versions
        }
        
    }
    @IBAction func mensajesTapped(sender: UIButton) {
        
        self.performSegueWithIdentifier(mensajesSegue, sender: self)
    }

}
