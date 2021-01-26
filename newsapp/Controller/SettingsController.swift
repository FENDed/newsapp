//
//  SettingsController.swift
//  newsapp
//
//  Created by User on 6.01.21.
//  Copyright © 2021 VladK. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {
    
   // let ref = Database.database().reference()
    
    let countryLabel = UILabel()
    let pickerView = UIPickerView()
    let newsTypeSwitch = UISwitch()
    let leftSwitchText = UILabel()
    let rightSwitchText = UILabel()
    let descriptionText = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureCountryLabel()
        configurePickerView()
        configureNewsTypeSwitch()
        configureSwitchRightText()
        configureDescriptionText()
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
        countryLabel.font = UIFont.systemFont(ofSize: 16)
        countryLabel.text = "Country"
        
        view.addSubview(countryLabel)
        addConstraintsOnCountryLabel()
    }
    
    func addConstraintsOnCountryLabel() {
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        countryLabel.topAnchor.constraint(equalTo:  view.topAnchor, constant: 100).isActive = true
        countryLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
    }
    
    func configurePickerView() {
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.selectRow(UserDefaults.standard.integer(forKey: "selectedRow"), inComponent: 0, animated: true)
        
        view.addSubview(pickerView)
        addConstraintsOnPickerView()
    }
    
    func addConstraintsOnPickerView() {
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        pickerView.leftAnchor.constraint(equalTo: countryLabel.rightAnchor, constant: 20).isActive = true
        pickerView.topAnchor.constraint(equalTo: countryLabel.topAnchor).isActive = true
        pickerView.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    func configureNewsTypeSwitch() {
        newsTypeSwitch.isOn = UserDefaults.standard.bool(forKey: "isSwitchOn")
        newsTypeSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        
        view.addSubview(newsTypeSwitch)
        addConstraintsOnNewsTypeSwitch()
    }
    
    func addConstraintsOnNewsTypeSwitch() {
        newsTypeSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        newsTypeSwitch.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 20).isActive = true
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
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: Notification.Name("reloadTableView"), object: nil)
    }
    
    @objc func switchChanged(sender: UISwitch!) {
        if sender.isOn {
            //dbUpdateSwitch(isOn: true)
            UserDefaults.standard.setValue(true, forKey: "isSwitchOn")
            Api.newsType = "top-headlines"
        }else {
            //dbUpdateSwitch(isOn: false)
            UserDefaults.standard.setValue(false, forKey: "isSwitchOn")
            Api.newsType = "everything"
        }
        NotificationCenter.default.post(name: Notification.Name("reloadTableView"), object: nil)
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
        return Constants.pickerData.count
    }
}

extension SettingsController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let rowText = Constants.pickerData[row]
        
        return rowText
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        UserDefaults.standard.setValue(row, forKey: "selectedRow")
        Api.country = localeForCountry(countryName: Constants.pickerData[row]) ?? "ru"
    }
}
