//
//  DrawerProfileCell.swift
//  Drawer Menu App
//
//  Created by Artem Korzh on 14.10.2020.
//

import UIKit

class DrawerProfileCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.cornerRadius = 30
        avatarImageView.clipsToBounds = true
    }
    
}
