//
//  ContainerController.swift
//  newsapp
//
//  Created by VladK on 4.01.21.
//

import UIKit


class ContainerController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    

    
    var menuController: MenuController!
    var centerController: UIViewController!
    var scrollView = UIScrollView()
    var searchBar = UISearchBar()
    let id = "tableCell"
    var newsTableView = UITableView()
    let homeController = HomeController()
    
    var isExpanded = false
    var newsData: [ApiNews] = []
    var buttons: [UIButton] = []
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView(noti:)), name: Notification.Name("reloadTableView"), object: nil)
        
        configureHomeController()
        newsData = fetchData()
        configureSearchBar()
        configureScrollView()
        configureNewsTableView()
        
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return isExpanded
    }
    
    func configureSearchBar() {
        searchBar.delegate = self
        view.addSubview(searchBar)
        
        addConstraintsOnSearchBar()
    }
    
    func addConstraintsOnSearchBar() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        searchBar.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        searchBar.leftAnchor.constraint(equalTo: centerController.view.leftAnchor, constant: 0).isActive = true
    }
    
    func configureScrollView() {
        scrollView.backgroundColor = .black
        
        view.addSubview(scrollView)
        addConstraintsOnScrollView()
        addButtonsInScrollView()
    }
    
    func addConstraintsOnScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        scrollView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10).isActive = true
        scrollView.leftAnchor.constraint(equalTo: centerController.view.leftAnchor, constant: 0).isActive = true
    }
    
    func addButtonsInScrollView() {
        for (index, elem) in Constants.categories.enumerated() {
            let button = UIButton()
            button.setTitle(elem, for: .normal)
            button.layer.borderWidth = 1
            button.layer.cornerRadius = 10
            button.sizeToFit()
            buttons.append(button)
            scrollView.addSubview(button)
            scrollView.contentSize.width += button.frame.size.width + 25
            
            button.addTarget(self, action: #selector(buttonGetNewsFromCategory), for: .touchUpInside)
                
            button.translatesAutoresizingMaskIntoConstraints = false
            if index == 0 {
                button.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10).isActive = true
            }else {
                button.leftAnchor.constraint(equalTo: buttons[index - 1].rightAnchor, constant: 25).isActive = true
            }
            
            button.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        }
    }
    

    func configureNewsTableView() {
        newsTableView.register(NewsTableCell.self, forCellReuseIdentifier: id)
        self.view.sendSubviewToBack(newsTableView)
        self.newsTableView.delegate = self
        self.newsTableView.dataSource = self
        
        view.addSubview(newsTableView)
        addConstraintsOnNewsTableView()
    }
    
    func addConstraintsOnNewsTableView() {
        newsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        newsTableView.leftAnchor.constraint(equalTo: centerController.view.leftAnchor, constant: 0).isActive = true
        newsTableView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 10).isActive = true
        newsTableView.heightAnchor.constraint(equalToConstant: view.frame.height - 200).isActive = true
        newsTableView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: id) as! NewsTableCell
        let someNews = newsData[indexPath.row]
        cell.set(news: someNews)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewsPageController()
        vc.newsData = newsData[indexPath.row]
        present(vc, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        Api.query = searchBar.text ?? ""
        fetchData()
    }
    
    
    func configureHomeController() {
        homeController.delegate = self
        
        centerController = UINavigationController(rootViewController: homeController)
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)

    }
    
    func configureMenuController() {
        if menuController == nil {
            // add menu controller
            menuController = MenuController()
            menuController.delegate = self
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
        }
    }
    
    func animatePanel(shouldExpand: Bool, menuOption: MenuOption?) {
        if shouldExpand {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 80
                self.newsTableView.frame.origin.x = self.newsTableView.frame.width - 80
                self.scrollView.frame.origin.x = self.scrollView.frame.width - 80
                self.searchBar.frame.origin.x = self.searchBar.frame.width - 80
            }, completion: nil)
        }else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = 0
                self.newsTableView.frame.origin.x = 0
                self.scrollView.frame.origin.x = 0
                self.searchBar.frame.origin.x = 0
            }) { (_) in
                guard let menuOption = menuOption else { return }
                self.didSelectMenuOption(menuOption: menuOption)
            }
        }
        
        animateStatusBar()

    }
    
    func didSelectMenuOption(menuOption: MenuOption) {
        switch menuOption {
        case .BookMarks:
            let controller = BookMarksController()
            presentInFullScreen(UINavigationController(rootViewController: controller), animated: true, completion: nil)
        case .Settings:
            let controller = SettingsController()
            presentInFullScreen(UINavigationController(rootViewController: controller), animated: true, completion: nil)
        }
    }
    
    func animateStatusBar() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        }, completion: nil)
    }
    
    @objc func reloadTableView(noti: Notification) {
        fetchData()
    }
    
    @objc func buttonGetNewsFromCategory(sender: UIButton!) {
        Api.category = sender.titleLabel?.text ?? ""
        fetchData()
    }
}

extension ContainerController: HomeControllerDelegate {

    func handleMenuToggle(forMenuOption menuOption: MenuOption?) {
        
        if !isExpanded {
            configureMenuController()
        }
        
        isExpanded = !isExpanded
        animatePanel(shouldExpand: isExpanded, menuOption: menuOption)
    }
}

extension ContainerController {
    func fetchData() -> [ApiNews] {
        let apiUrl = "https://newsapi.org/v2/\(Api.newsType)?apiKey=\(Api.apiKey)&category=\(Api.newsType == "everything" ? "" : Api.category)&country=\(Api.newsType == "everything" ? "" : (Api.country))&q=\(Api.query)"
        getData(from: apiUrl) { (news) in
            DispatchQueue.main.async {
                self.newsData = news
                self.newsTableView.reloadData()
            }
        }
            
        return []
    }
    
    func getData(from url: String, comlpletion: @escaping ( [ApiNews] ) -> Void) {

        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print("Request API error")
                return
            }
            print("\(data)\n\n\n")
            
            var result:News?
            do {
                result = try JSONDecoder().decode(News.self, from: data)
                
                if result?.status == "error" {
                    print("Error: \(result?.message ?? "no message")")
                }
                
            }
            catch {
                print("Failed to convert \(error.localizedDescription)")
            }
            
            guard let json = result?.articles else {
                return
            }
            comlpletion(json)
            
            
        }).resume()
        return
    }
}

extension UIViewController {
  func presentInFullScreen(_ viewController: UIViewController,
                           animated: Bool,
                           completion: (() -> Void)? = nil) {
    viewController.modalPresentationStyle = .fullScreen
    present(viewController, animated: animated, completion: completion)
  }
}
