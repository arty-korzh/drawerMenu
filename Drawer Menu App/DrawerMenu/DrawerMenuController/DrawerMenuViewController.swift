//
//  DrawerMenuViewController.swift
//  Drawer Menu App
//
//  Created by Artem Korzh on 26.09.2020.
//

import UIKit

enum DrawerMenuOption: String, CaseIterable {
    case profile
    case home
    case messages
    case settings
    case logout

    var title: String {
        return rawValue.capitalized
    }

    var icon: UIImage? {
        switch self {
        case .profile:
            return UIImage(named: "profile_picture")
        case .home:
            return UIImage(systemName: "house")
        case .messages:
            return UIImage(systemName: "bubble.left.and.bubble.right")
        case .settings:
            return UIImage(systemName: "gearshape")
        case .logout:
            return UIImage(systemName: "arrow.uturn.left.circle")
        }
    }

}


protocol DrawerMenuDelegate: class {
    func drawerMenuOptionSelected(_ option: DrawerMenuOption)
}

class DrawerMenuViewController: UIViewController {

    @IBOutlet weak var menuTableView: UITableView!

    static var selectedOption: DrawerMenuOption = .home

    let transitionManager = DrawerTransitionManager()

    weak var delegate: DrawerMenuDelegate?

    init(delegate: DrawerMenuDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
        modalPresentationStyle = .custom
        transitioningDelegate = transitionManager
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        menuTableView.register(UINib(nibName: "DrawerMenuCell", bundle: nil), forCellReuseIdentifier: "menuCell")
        menuTableView.register(UINib(nibName: "DrawerProfileCell", bundle: nil), forCellReuseIdentifier: "profileCell")

        setSelectedOption()
    }

    private func setSelectedOption() {
        if [DrawerMenuOption.profile, DrawerMenuOption.logout].contains(Self.selectedOption) {
            return
        }
        guard let selectedIndex = DrawerMenuOption.allCases.firstIndex(of: Self.selectedOption) else {
            return
        }

        menuTableView.selectRow(at: IndexPath(row: selectedIndex, section: 0), animated: false, scrollPosition: .top)
    }

}


extension DrawerMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DrawerMenuOption.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let option = DrawerMenuOption.allCases[indexPath.row]
        switch option {
        case .profile:
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! DrawerMenuCell
            cell.titleLabel.text = option.title
            cell.iconImageView.image = option.icon
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let option = DrawerMenuOption.allCases[indexPath.row]
        return option == .profile ? 100 : 50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let option = DrawerMenuOption.allCases[indexPath.row]
        Self.selectedOption = option
        dismiss(animated: true) {
            self.delegate?.drawerMenuOptionSelected(option)
        }
    }


}
