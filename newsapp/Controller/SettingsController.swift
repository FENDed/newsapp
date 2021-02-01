//
//  SettingsController.swift
//  newsapp
//
//  Created by User on 6.01.21.
//  Copyright © 2021 VladK. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {
    
    let countryLabel = UILabel()
    let countryPickerView = UIPickerView()
    let sourcePickerView = UIPickerView()
    let newsTypeSwitch = UISwitch()
    let leftSwitchText = UILabel()
    let rightSwitchText = UILabel()
    let descriptionText = UILabel()
    let sourceLabel = UILabel()
    let createPasswordButton = UIButton()
    let deletePasswordButton = UIButton()
    let setPasswordAlertController = UIAlertController()
    let deletePasswordAlertController = UIAlertController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureCountryLabel()
        configurePickerView()
        configureNewsTypeSwitch()
        configureSwitchRightText()
        configureDescriptionText()
        configureSourceLabel()
        configureSourcePickerView()
        configureCreatePasswordButton()
        configureDeletePasswordButton()
        configureSetPasswordAlertController()
        configureDeletePasswordAlertController()
    }

    func configureView() {
        view.backgroundColor = .white
        
        
        navigationController?.navigationBar.barTintColor = .darkGray
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.title = "Settings"
        navigationController?.navigationBar.barStyle = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(handleDismiss))
    }
    
    func configureCountryLabel() {
        countryLabel.font = UIFont.systemFont(ofSize: 20)
        countryLabel.text = "Country"
        countryLabel.textAlignment = .center
        
        view.addSubview(countryLabel)
        addConstraintsOnCountryLabel()
    }
    
    func addConstraintsOnCountryLabel() {
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        countryLabel.topAnchor.constraint(equalTo:  view.topAnchor, constant: 100).isActive = true
        countryLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        countryLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
    }
    
    func configurePickerView() {
        countryPickerView.dataSource = self
        countryPickerView.delegate = self
        countryPickerView.selectRow(UserDefaults.standard.integer(forKey: "selectedRow"), inComponent: 0, animated: true)
        
        view.addSubview(countryPickerView)
        addConstraintsOnPickerView()
    }
    
    func addConstraintsOnPickerView() {
        countryPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        countryPickerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        countryPickerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        countryPickerView.topAnchor.constraint(equalTo: countryLabel.topAnchor, constant: 20).isActive = true
        countryPickerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func configureNewsTypeSwitch() {
        newsTypeSwitch.isOn = UserDefaults.standard.bool(forKey: "isSwitchOn")
        newsTypeSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        
        view.addSubview(newsTypeSwitch)
        addConstraintsOnNewsTypeSwitch()
    }
    
    func addConstraintsOnNewsTypeSwitch() {
        newsTypeSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        newsTypeSwitch.topAnchor.constraint(equalTo: countryPickerView.bottomAnchor, constant: 20).isActive = true
        newsTypeSwitch.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
    }
    
    
    func configureSwitchRightText() {
        rightSwitchText.text = "Display only top headlines"
        view.addSubview(rightSwitchText)
        
        addConstraintsOnSwitchRightText()
    }
    
    func addConstraintsOnSwitchRightText() {
        rightSwitchText.translatesAutoresizingMaskIntoConstraints = false
        
        rightSwitchText.centerYAnchor.constraint(equalTo: newsTypeSwitch.centerYAnchor).isActive = true
        rightSwitchText.leftAnchor.constraint(equalTo: newsTypeSwitch.rightAnchor, constant: 10).isActive = true
    }
    
    func configureDescriptionText() {
        descriptionText.text = "To sell all news, use search panel"
        descriptionText.font = UIFont.systemFont(ofSize: 12)
        descriptionText.tintColor = .darkGray
        
        view.addSubview(descriptionText)
        addConstraintsOnDescriptionText()
    }
    
    func addConstraintsOnDescriptionText() {
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionText.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        descriptionText.topAnchor.constraint(equalTo: newsTypeSwitch.bottomAnchor, constant: 10).isActive = true
    }
    
    func configureSourceLabel() {
        sourceLabel.text = "Source"
        sourceLabel.font = UIFont.systemFont(ofSize: 20)
        sourceLabel.textAlignment = .center
        
        view.addSubview(sourceLabel)
        
        addConstraintsOnSourceLabel()
    }
    
    func addConstraintsOnSourceLabel() {
        sourceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        sourceLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        sourceLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        sourceLabel.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 20).isActive = true
    }
    
    func configureSourcePickerView() {
        sourcePickerView.dataSource = self
        sourcePickerView.delegate = self
        sourcePickerView.selectRow(UserDefaults.standard.integer(forKey: "selectedSourceRow"), inComponent: 0, animated: true)
        view.addSubview(sourcePickerView)
        
        addConstraintsOnSourcePickerView()
    }
    
    func addConstraintsOnSourcePickerView() {
        sourcePickerView.translatesAutoresizingMaskIntoConstraints = false
        
        sourcePickerView.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: 10).isActive = true
        sourcePickerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        sourcePickerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        sourcePickerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func configureCreatePasswordButton() {
        if UserDefaults.standard.string(forKey: "bookmarksPassword")?.count ?? 0 > 0 {
            createPasswordButton.alpha = 0
        } else {
            createPasswordButton.alpha = 1
        }
        createPasswordButton.setTitle("Create password for bookmarks", for: .normal)
        createPasswordButton.setTitleColor(.systemBlue, for: .normal)
        createPasswordButton.addTarget(self, action: #selector(createPassword), for: .touchUpInside)
        
        view.addSubview(createPasswordButton)
        
        addConstraintsOnCreatePasswordButton()
    }
    
    func addConstraintsOnCreatePasswordButton() {
        createPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        createPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        createPasswordButton.topAnchor.constraint(equalTo: sourcePickerView.bottomAnchor, constant: 20).isActive = true
        createPasswordButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func configureDeletePasswordButton() {
        if UserDefaults.standard.string(forKey: "bookmarksPassword")?.count ?? 0 > 0 {
            deletePasswordButton.alpha = 1
        } else {
            deletePasswordButton.alpha = 0
        }
        view.addSubview(deletePasswordButton)
        deletePasswordButton.setTitle("Delete password from bookmarks", for: .normal)
        deletePasswordButton.setTitleColor(.systemRed, for: .normal)
        deletePasswordButton.addTarget(self, action: #selector(deletePassword), for: .touchUpInside)
        
        addConstraintsOnDeletePasswordButton()
    }
    
    func addConstraintsOnDeletePasswordButton() {
        deletePasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        deletePasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        deletePasswordButton.topAnchor.constraint(equalTo: sourcePickerView.bottomAnchor, constant: 20).isActive = true
        deletePasswordButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func configureSetPasswordAlertController() {
        setPasswordAlertController.title = "Do you want to create password for bookmarks?"
        setPasswordAlertController.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
        setPasswordAlertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            let setPasswordAlert = UIAlertController(title: "Set your password", message: nil, preferredStyle: .alert)
            setPasswordAlert.addTextField { (field) in
                field.isSecureTextEntry = true
            }
            setPasswordAlert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
            setPasswordAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (confirm) in
                let userinput = setPasswordAlert.textFields?.first
                if userinput?.text?.count ?? 0 <= 3 {
                    let errorCreatePasswordAlertController = UIAlertController(title: "Error: Length of password swould be 4 and more symbols", message: nil, preferredStyle: .alert)
                    errorCreatePasswordAlertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(errorCreatePasswordAlertController, animated: true, completion: nil)
                }
                UserDefaults.standard.setValue(userinput?.text ?? "", forKey: "bookmarksPassword")
                UserDefaults.standard.setValue(false, forKey: "isAuth")
                self.deletePasswordButton.alpha = 1
                self.createPasswordButton.alpha = 0

            }))
            self.present(setPasswordAlert, animated: true, completion: nil)
        }))
    }
    
    func configureDeletePasswordAlertController() {
        deletePasswordAlertController.title = "Do you want to delete password for bookmarks?"
        deletePasswordAlertController.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
        deletePasswordAlertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            let deletePasswordAlert = UIAlertController(title: "Enter your current password", message: nil, preferredStyle: .alert)
            deletePasswordAlert.addTextField { (field) in
                field.isSecureTextEntry = true
            }
            deletePasswordAlert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
            deletePasswordAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (confirm) in
                let userinput = deletePasswordAlert.textFields?.first
                if userinput?.text ?? "" == UserDefaults.standard.string(forKey: "bookmarksPassword") {
                    let successDeletePasswordAlertController = UIAlertController(title: "Password deleted!", message: nil, preferredStyle: .alert)
                    successDeletePasswordAlertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    UserDefaults.standard.setValue("", forKey: "bookmarksPassword")
                    UserDefaults.standard.setValue(true, forKey: "isAuth")
                    self.present(successDeletePasswordAlertController, animated: true, completion: nil)
                    self.deletePasswordButton.alpha = 0
                    self.createPasswordButton.alpha = 1
                } else {
                    let errorDeletePasswordAlertController = UIAlertController(title: "Error: Uncorrect password", message: nil, preferredStyle: .alert)
                    errorDeletePasswordAlertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(errorDeletePasswordAlertController, animated: true, completion: nil)
                }
            }))
            self.present(deletePasswordAlert, animated: true, completion: nil)
        }))
    }
    
    
    
    @objc func handleDismiss() {
        Api.page = 1
        dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: Notification.Name("reloadTableView"), object: nil)
    }
    
    @objc func switchChanged(sender: UISwitch!) {
        if sender.isOn {
            UserDefaults.standard.setValue(true, forKey: "isSwitchOn")
            Api.newsType = "top-headlines"
        }else {
            UserDefaults.standard.setValue(false, forKey: "isSwitchOn")
            Api.newsType = "everything"
            
            let errorAlert = UIAlertController(title: "Note", message: "To use everything type, you should select source and use search bar", preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(errorAlert, animated: true, completion: nil)
        }
        NotificationCenter.default.post(name: Notification.Name("reloadTableView"), object: nil)
    }
    
    @objc func createPassword(sender: UIButton!) {
        present(setPasswordAlertController, animated: true, completion: nil)
    }
    
    @objc func deletePassword(sender: UIButton!) {
        present(deletePasswordAlertController, animated: true, completion: nil)
    }
    
    func localeForCountry(countryName : String) -> String?
    {
        return NSLocale.isoCountryCodes.first{self.countryNameFromLocaleCode(localeCode: $0 ) == countryName}
    }

    func countryNameFromLocaleCode(localeCode : String) -> String
    {
        return NSLocale(localeIdentifier: Locale.current.regionCode ?? "en_US").displayName(forKey: NSLocale.Key.countryCode, value: localeCode) ?? ""
    }
}

extension SettingsController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView ==  countryPickerView {
            return Constants.pickerData.count
        }else {
            return Constants.sourceData.count
        }
        
    }
}

extension SettingsController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == countryPickerView {
            let rowText = Constants.pickerData[row]
            return rowText
        }else {
            let rowText = Constants.sourceData[row]
            return rowText
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == countryPickerView {
            UserDefaults.standard.setValue(row, forKey: "selectedRow")
            UserDefaults.standard.setValue(localeForCountry(countryName: Constants.pickerData[row]) ?? "ru", forKey: "country")
            Api.country = localeForCountry(countryName: Constants.pickerData[row]) ?? "ru"
            
        }
        if pickerView == sourcePickerView {
            UserDefaults.standard.setValue(row, forKey: "selectedSourceRow")
            UserDefaults.standard.setValue((row == 0) ? "" : Constants.sourceDataId[row], forKey: "source")
            Api.source = Constants.sourceDataId[row]
        }
    }
}
