//
//  OnBoardingViewController.swift
//  newsapp
//
//  Created by User on 31.01.21.
//  Copyright © 2021 VladK. All rights reserved.
//

import UIKit

class OnBoardingViewController: UIViewController {

    let scrollView = UIScrollView()
    let boardingImage1 = UIImage(named: "boarding-1")
    let boardingImage2 = UIImage(named: "boarding-2")
    let nextButton = UIButton()
    let finishButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
        view.backgroundColor = .black
        configureScrollView()
        addFirstBoardingScreen()
        addSecondBoardingScreen()
        configureNextButton()
        configureFinishButton()
    }
    
    func configureScrollView() {
        scrollView.contentSize = CGSize(width: view.frame.width * 2, height: view.frame.height)
        scrollView.isScrollEnabled = false
        view.addSubview(scrollView)
        
        addConstraintsOnScrollView()
    }
    
    func configureNextButton() {
        nextButton.setTitle("Next", for: .normal)
        nextButton.frame = CGRect(x: view.frame.width - 120, y: view.frame.height - 100, width: 100, height: 50)
        nextButton.backgroundColor = .black
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.addTarget(self, action: #selector(nextSlide), for: .touchUpInside)
        scrollView.addSubview(nextButton)
    }
    
    func configureFinishButton() {
        finishButton.setTitle("Finish", for: .normal)
        finishButton.frame = CGRect(x: view.frame.width * 2 - 140, y: view.frame.height - 100, width: 100, height: 50)
        finishButton.backgroundColor = .black
        finishButton.setTitleColor(.white, for: .normal)
        finishButton.addTarget(self, action: #selector(finish), for: .touchUpInside)
        scrollView.addSubview(finishButton)
    }
    
    func addConstraintsOnScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    func addFirstBoardingScreen() {
        let boardingImage1View = UIImageView(image: boardingImage1)
        boardingImage1View.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.addSubview(boardingImage1View)
    }
    
    func addSecondBoardingScreen() {
        let boardingImage2View = UIImageView(image: boardingImage2)
        boardingImage2View.frame = CGRect(x: view.frame.width, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.addSubview(boardingImage2View)
    }
    
    @objc func nextSlide(sender: UIButton!) {
        scrollView.setContentOffset(CGPoint(x: view.frame.width, y: 0), animated: true)
        sender.alpha = 0
    }
    
    @objc func finish(sender: UIButton!) {
        view.alpha = 0
        UserDefaults.standard.setValue(true, forKey: "isNewUser")
    }
}
