//
//  VerMensajesViewController.swift
//  Catalogo
//
//  Created by Nora Hilda De los Reyes on 30/03/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse


class VerMensajesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    var arrayMensajes: [PFObject] = []
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    let nombre = "usuarioDelMensaje", userName = "username", descripcion = "mensajeDescripcion", precio = "precio", cantidad =  "cantidad", pedir = "pedir"
    
    
    @IBAction func salirTapped(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let queryMessages = PFQuery(className: "Mensajes")
        
        queryMessages.whereKey("visto", equalTo: false)
        queryMessages.limit = 200
        queryMessages.addDescendingOrder("createdAt")
        queryMessages.includeKey("usuarioDelMensaje")
        
        do {
            
            arrayMensajes = try queryMessages.findObjects()
            
        } catch let error {
            
            print(error)
        }
        
        print(arrayMensajes.count)
        print("we got them \(self.arrayMensajes.count)")
        print(arrayMensajes[0].valueForKey("mensajeDescripcion")!)
        print(arrayMensajes[0].valueForKey("visto")!)
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
 
//        queryMessages.findObjectsInBackgroundWithBlock {
//            
//            (objects: [PFObject]?, error: NSError? ) -> Void in
//            
//            if error == nil {
//                
//                self.arrayMensajes = objects!
//                print("we got them \(self.arrayMensajes.count)")
//                
//                print("prueba \(self.arrayMensajes[0].valueForKey(self.nombre)!.valueForKey(self.userName)!)")
//                print(self.arrayMensajes[0].valueForKey(self.nombre)!.valueForKey(self.userName)! as? String)
//                
//                
//                
//            } else {
//                
//                print(error?.localizedDescription)
//                
//                
//            }
//        }
//        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("this second")
        return arrayMensajes.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            
            return "Mensajes Nuevos"
            
        } else {
            
            
            return "Productos"
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("VerMensajesCell", forIndexPath: indexPath) as! VerMensajesTableViewCell
        //print("prueba \(arrayMensajes[indexPath.row].valueForKey(nombre)!.valueForKey(userName)!)")
        //print(arrayMensajes[indexPath.row].valueForKey("usuarioDelMensaje")!.valueForKey("Username")! as? String)
        print("this fucking index is driving me crazy \(indexPath.row) and this \(arrayMensajes.count)")
        cell.usernameMessagesLabel.text = arrayMensajes[indexPath.row].valueForKey("usuarioDelMensaje")!.valueForKey("username")! as? String
        cell.massageLabel.text = arrayMensajes[indexPath.row].valueForKey("mensajeDescripcion")! as? String
        
        
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
            
            print("index of this row \(indexPath.row)")
            print("object at index \(arrayMensajes[indexPath.row])")
            let queryVisto = PFQuery(className: "Mensajes")
            
            print(arrayMensajes[indexPath.row].objectId!)
            print(indexPath.row)
            
            queryVisto.getObjectInBackgroundWithId(arrayMensajes[indexPath.row].objectId!) {
                
                (objectSeen: PFObject?, error: NSError?) -> Void in
                
                if error == nil {
                    
                    print(objectSeen!["visto"])
                    print(objectSeen!.objectId!)
                    objectSeen!["visto"] = true
                    objectSeen!.saveInBackground()
                    
                } else {
                    
                    print(error)
                }
                
            }
            
            arrayMensajes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
            
            tableView.reloadData()
            
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            
            //tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Right)
        }
    }
    
    
    
    // Override to support rearranging the table view.
    func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        
    }
}
