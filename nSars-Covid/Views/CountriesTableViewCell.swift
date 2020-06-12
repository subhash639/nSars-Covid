//
//  CountriesTableViewCell.swift
//  nSars-Covid
//
//  Created by Subhash Tummala on 5/1/20.
//  Copyright © 2020 Subhash Tummala. All rights reserved.
//

import UIKit

class CountriesTableViewCell: UITableViewCell {

    var cellTitle = UILabel()
    var cellLineOne = UILabel()
    var cellLineTwo = UILabel()
    var cellLineThree = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        accessoryType = .disclosureIndicator
        addSubview(cellTitle)
        addSubview(cellLineOne)
        addSubview(cellLineTwo)
        addSubview(cellLineThree)
        setupTableCells()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupTableCells(){
        //Adding subviews to table cell view
        
        titleLabelConstraints()
        
        //Constraints will go here
    }
    
    func setCellData(countries: Country){
        cellTitle.text = countries.country
        cellLineOne.text = "Cases: \(countries.cases) | Today: \(countries.todayCases) | Active: \(countries.active)"
        cellLineTwo.text = "Deaths: \(countries.deaths) | Today: \(countries.todayDeaths)"
        cellLineThree.text = "Recovered: \(countries.recovered ?? 0) | Critical: \(countries.critical)"
    }
    
    func titleLabelConstraints() {
        labelDefaults(view: cellTitle, fontSize: 30)
        labelDefaults(view: cellLineOne, fontSize: 15)
        labelDefaults(view: cellLineTwo, fontSize: 15)
        labelDefaults(view: cellLineThree, fontSize: 15)
        
        cellTitle.translatesAutoresizingMaskIntoConstraints = false
        cellTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        cellTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        cellTitle.heightAnchor.constraint(equalToConstant: 28).isActive = true
        cellTitle.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        
        cellLineOne.pin(to: cellTitle)
        cellLineTwo.pin(to: cellLineOne)
        cellLineThree.pin(to: cellLineTwo)
    }
    
    func labelDefaults(view:UILabel, fontSize:CGFloat) {
        view.adjustsFontSizeToFitWidth = true
        view.numberOfLines = 0
        view.font = UIFont(name: "Avenir-Heavy", size: fontSize)
    }
}

extension UIView {
    func pin(to superView: UIView){
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 0).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: 0).isActive = true
        heightAnchor.constraint(equalToConstant: 18).isActive = true
        topAnchor.constraint(equalTo: superView.bottomAnchor, constant: 0).isActive = true
    }
}
