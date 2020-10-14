//
//  DrawerMenuCell.swift
//  Drawer Menu App
//
//  Created by Artem Korzh on 14.10.2020.
//

import UIKit

class DrawerMenuCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        iconImageView.tintColor = selected ? .systemPink : .systemGray
    }
    
}
