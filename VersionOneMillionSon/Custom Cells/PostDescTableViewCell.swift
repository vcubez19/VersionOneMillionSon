//
//  PostDescTableViewCell.swift
//  VersionOneMillionSon
//
//  Created by Vincent Cubit on 11/27/21.
//


import UIKit


class PostDescTableViewCell: UITableViewCell {

    
    static let id = "PostDescTableViewCell"
    
    
    let textReference = TextViewTableViewCell()
    
    
    private let labelDesc: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.labelDesc)
        self.labelDesc.text = UserDefaults.standard.string(forKey: "TempDescription")
        
        
        let constraints: [ NSLayoutConstraint ] = [
            self.labelDesc.leftAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leftAnchor),
            self.labelDesc.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor),
            self.labelDesc.rightAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.rightAnchor),
            self.labelDesc.centerYAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.centerYAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    

    

}

