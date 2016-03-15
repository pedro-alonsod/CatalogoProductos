//
//  ProductosTableViewCell.swift
//  Catalogo
//
//  Created by Nora Hilda De los Reyes on 14/03/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class ProductosTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var productoImg: UIImageView!
    @IBOutlet weak var productoImageView: UIView!
    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var descripcionLabel: UILabel!
    @IBOutlet weak var cantidadLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
