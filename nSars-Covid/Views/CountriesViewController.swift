//
//  CountriesViewController.swift
//  nSars-Covid
//
//  Created by Subhash Tummala on 5/1/20.
//  Copyright © 2020 Subhash Tummala. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController {
    
    var countryTableView = UITableView(frame: .zero, style: .plain)
    var rows = 0
    var countries:[Country]?
    var service = NetworkHandler()
    let identifier = "CountriesTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Countries"
        
        fetchData()
        setupTableView()
        countryTableView.reloadData()
    }
    
    func setupTableView() {
        countryTableView.delegate = self
        countryTableView.dataSource = self
        
        view.addSubview(countryTableView)
        countryTableView.register(CountriesTableViewCell.self, forCellReuseIdentifier: identifier)
        countryTableView.rowHeight = 100
        tableviewConstraints()
    }
    
    func tableviewConstraints(){
        countryTableView.translatesAutoresizingMaskIntoConstraints = false
        countryTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        countryTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        countryTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        countryTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    // MARK: - Table view data source

    

}

extension CountriesViewController: UITableViewDelegate, UITableViewDataSource {
    func fetchData(){
        service.fetchCountries() { [weak self](country) in
            guard let strongSelf = self else { return }
            print(String(describing: country))
            if let country = country {
                strongSelf.countries = country
                strongSelf.rows = country.count
            }
            OperationQueue.main.addOperation({
                strongSelf.countryTableView.reloadData()
            })
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! CountriesTableViewCell
        let country = countries?[indexPath.row]
        if let country = country {
            cell.setCellData(countries: country)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let country = countries?[indexPath.row]{
            let vc = CountryViewController()
            vc.path = "countries/" + country.country
            show(vc, sender: self)
        }
    }
}
