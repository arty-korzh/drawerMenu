//
//  ViewController.swift
//  Drawer Menu App
//
//  Created by Artem Korzh on 26.09.2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var containerView: UIView!

    var currentController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        setCurrentView(for: .home)
    }

    @IBAction func didTapMenu(_ sender: Any) {
        let drawerController = DrawerMenuViewController(delegate: self)
        present(drawerController, animated: true)
    }
}

extension ViewController: DrawerMenuDelegate {
    func drawerMenuOptionSelected(_ option: DrawerMenuOption) {
        switch option {
        case .logout:
            let alert = UIAlertController(title: "Logout", message: "You have successfully logged out", preferredStyle: .alert)
            alert.addAction(.init(title: "Ok", style: .default))
            present(alert, animated: true)
        default:
            setCurrentView(for: option)
        }
    }

    func setCurrentView(for option: DrawerMenuOption) {
        navigationBar.topItem?.title = option.title

        currentController?.view.removeFromSuperview()
        currentController?.removeFromParent()

        let newController = AppScreenViewController(option: option)
        containerView.addSubview(newController.view)
        newController.view.frame = containerView.bounds
        newController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addChild(newController)
        currentController = newController
    }
}

