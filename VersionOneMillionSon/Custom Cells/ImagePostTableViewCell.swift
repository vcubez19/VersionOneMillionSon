//
//  ImagePostTableViewCell.swift
//  VersionOneMillionSon
//
//  Created by Vincent Cubit on 11/27/21.
//


import UIKit


class ImagePostTableViewCell: UITableViewCell {
    
    
    static let id = "ImagePostTableViewCell"
    
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        return imageView
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.postImageView)
        self.postImageView.image = UIImage(named: "purple-plant.png")
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.postImageView.frame = self.contentView.bounds
    }
    

}

