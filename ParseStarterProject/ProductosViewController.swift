//
//  ProductosViewController.swift
//  Catalogo
//
//  Created by Nora Hilda De los Reyes on 14/03/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class ProductosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let detallesSegue = "DetallesSegue"
    let cellDetailsSegue = "CellDetailSegue"
    
    @IBOutlet weak var tableView: UITableView!
    var arrayProductos: [PFObject] = []
    
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
    
    override func viewWillAppear(animated: Bool) {
        
        print("test 2")
        
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        print("test 3")
        self.tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        
        
        print("test 4 see which one is celled when i need it")
        tableView.reloadData()
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
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ProductosCell", forIndexPath: indexPath) as! ProductosTableViewCell
        
        
        if let pImg = arrayProductos[indexPath.row].valueForKey(foto) as? PFFile {


            do {
                
                pImg.getDataInBackgroundWithBlock {
                    
                    (data: NSData?, error: NSError?) -> Void in
                 
                    if error == nil {
                        
                        cell.productoImg.image = UIImage(data: data!)
                    }
                    
                }
            }

        }
        
        
        
        cell.nombreLabel.text = "Nombre: \(arrayProductos[indexPath.row].valueForKey(nombre)!) "
        
        cell.cantidadLabel.text = "#: \(arrayProductos[indexPath.row].valueForKey(cantidad)!)"
        
        cell.descripcionLabel.text = "Descripcion: \(arrayProductos[indexPath.row].valueForKey(descripcion)!)"
        
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
            
            arrayProductos.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            tableView.reloadData()
            
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
        
        let nombre = "nombre", foto = "Foto", descripcion = "descripcion", precio = "precio", cantidad =  "cantidad", pedir = "pedir"
        
        if segue.identifier == cellDetailsSegue {
            
            let DVC = segue.destinationViewController as! DetallesViewController
            
            
            let myIndexPath = self.tableView.indexPathForSelectedRow!
            let row = myIndexPath.row
            
            print("\(row) \(arrayProductos[row].valueForKey(descripcion))")
            
            let detailText = arrayProductos[row].valueForKey(descripcion)!
            let amount = arrayProductos[row].valueForKey(cantidad)!
            let name = arrayProductos[row].valueForKey(nombre)!
            let price = arrayProductos[row].valueForKey(precio)!
            let objectId = arrayProductos[row].objectId!
            let picture = arrayProductos[row].valueForKey(foto) as! PFFile
            
            
            print(picture.description)
            print(detailText)
            print(amount)
            print(name)
            print(objectId)
            
            DVC.productoDescripcion = detailText as! String
                
            DVC.productoCantided = amount as! String
                
            DVC.productoNombre = name as! String
            
            DVC.productoPrecio = price as! String
            
            DVC.productoObjectId = objectId
            
            DVC.productoImage = picture
            
            print(picture.description)
            
            
            
            
        }
    }
    

    @IBAction func salirTapped(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func agregarNuevoTapped(sender: UIButton) {
        
        
        self.performSegueWithIdentifier(detallesSegue, sender: self)
    }
    
    
}
