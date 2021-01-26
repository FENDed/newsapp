//
//  ContainerController.swift
//  newsapp
//
//  Created by User on 4.01.21.
//

import UIKit

class HomeController: UIViewController {
    
    var delegate: HomeControllerDelegate?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureNavigationBar()
    }
    
    @objc func handleMenuToggle() {
        delegate?.handleMenuToggle(forMenuOption: nil)
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor.init(cgColor: CGColor(red: 211 / 255, green: 47 / 255, blue: 47 / 255, alpha: 0))
        navigationController?.navigationBar.barStyle = .black
        
        navigationItem.title = "News app"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "burdermenu-white").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
    }
    
}
