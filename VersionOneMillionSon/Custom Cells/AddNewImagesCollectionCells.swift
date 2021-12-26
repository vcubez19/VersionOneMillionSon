//
//  AddNewImagesCollectionCells.swift
//  VersionOneMillionSon
//
//  Created by Vincent Cubit on 11/23/21.
//


import UIKit


class AddNewImagesCollectionCells: UICollectionViewCell {
    
    
    static let id = "AddNewImagesCollectionCells"
    
    
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 14)
        title.textAlignment = .center
        title.textColor = .white
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.tintColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.image)
        self.contentView.layer.cornerRadius = 20.0
        
        
        let constraints: [ NSLayoutConstraint ] = [
            self.image.leftAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leftAnchor, constant: 40),
            self.image.rightAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.rightAnchor, constant: -40),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.centerXAnchor),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.centerYAnchor),
            self.titleLabel.topAnchor.constraint(equalTo: self.image.bottomAnchor, constant: 10)
        ]
        NSLayoutConstraint.activate(constraints)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    public func configureCell(with title: String, image: String, color: UIColor) {
        self.titleLabel.text = title
        self.image.image = UIImage(systemName: image)
        self.contentView.backgroundColor = color
    }
    
    
}

