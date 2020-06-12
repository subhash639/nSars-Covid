//
//  ViewController.swift
//  nSars-Covid
//
//  Created by Subhash Tummala on 4/30/20.
//  Copyright © 2020 Subhash Tummala. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {

    var someButton = UIButton()
    var casesLabel = UILabel()
    var deathsLabel = UILabel()
    var recoveredLabel = UILabel()
//    var screenTitle = UILabel()
    var clearAllBtn = UIButton()
    var network = NetworkHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "Home"
//        screenTitle.text = "Home Screen"
//        self.navigationItem.titleView = screenTitle
        setupUI()
    }
    
    func setupUI() {
        setupButton()
        setupLabels()
        setupClearAllBtn()
    }
    
    func setupButton(){
        view.addSubview(someButton)
        someButton.backgroundColor = .orange
        someButton.setTitle("Click", for: .normal)
        someButton.setTitleColor(.white, for: .normal)
        
        someButton.translatesAutoresizingMaskIntoConstraints = false
        someButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        someButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        someButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        someButton.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
        
        someButton.addTarget(self, action: #selector(self.pressButton(_:)) , for: .touchUpInside)
    }
    
    func setupClearAllBtn(){
        view.addSubview(clearAllBtn)
        clearAllBtn.backgroundColor = .orange
        clearAllBtn.setTitle("Clear All", for: .normal)
        clearAllBtn.setTitleColor(.white, for: .normal)
        
        clearAllBtn.translatesAutoresizingMaskIntoConstraints = false
        clearAllBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        clearAllBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        clearAllBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        clearAllBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        
        clearAllBtn.addTarget(self, action: #selector(self.clearAll(_:)) , for: .touchUpInside)
    }
    
    @objc func clearAll(_ sender: UIButton){
        casesLabel.text = "Total Cases: 0"
        deathsLabel.text = "Total Deaths: 0"
        recoveredLabel.text = "Total Recovered: 0"
    }
    
    func setupLabels(){
        view.addSubview(casesLabel)
        view.addSubview(deathsLabel)
        view.addSubview(recoveredLabel)
        
        setFont(to: casesLabel)
        setFont(to: deathsLabel)
        setFont(to: recoveredLabel)
        
        casesLabel.translatesAutoresizingMaskIntoConstraints = false
        deathsLabel.translatesAutoresizingMaskIntoConstraints = false
        recoveredLabel.translatesAutoresizingMaskIntoConstraints = false
        
        casesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        casesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        casesLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        casesLabel.topAnchor.constraint(equalTo: someButton.bottomAnchor, constant: 40).isActive = true
        
        deathsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        deathsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        deathsLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        deathsLabel.topAnchor.constraint(equalTo: casesLabel.bottomAnchor, constant: 0).isActive = true
        
        recoveredLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        recoveredLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        recoveredLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        recoveredLabel.topAnchor.constraint(equalTo: deathsLabel.bottomAnchor, constant: 0).isActive = true
    }
    
    func setFont(to view:UILabel) {
        view.font = UIFont(name: "Avenir-Heavy", size: 20)
        view.textColor = .white
        view.textAlignment = .center
    }
    
    @objc func pressButton(_ sender: UIButton) {
        network.fetchStats(completion: { [weak self] (stats) in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async{
                strongSelf.casesLabel.text = "Total Cases: " + String(describing: stats.cases)
                strongSelf.deathsLabel.text = "Total Deaths: " + String(describing: stats.deaths)
                strongSelf.recoveredLabel.text = "Total Recovered: " + String(describing: stats.recovered)
            }
        })
        
    }
}

