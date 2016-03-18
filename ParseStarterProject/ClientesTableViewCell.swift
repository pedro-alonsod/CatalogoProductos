//
//  ClientesTableViewCell.swift
//  Catalogo
//
//  Created by Nora Hilda De los Reyes on 18/03/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class ClientesTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var nombreProducto: UILabel!
    @IBOutlet weak var descripcionProducto: UILabel!
    @IBOutlet weak var precioProducto: UILabel!
    @IBOutlet weak var imagenProducto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
