//
//  AppScreenViewController.swift
//  Drawer Menu App
//
//  Created by Artem Korzh on 14.10.2020.
//

import UIKit

class AppScreenViewController: UIViewController {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    let selectedOption: DrawerMenuOption

    init(option: DrawerMenuOption) {
        selectedOption = option
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = selectedOption.title
        iconImageView.image = selectedOption.icon
    }
}
