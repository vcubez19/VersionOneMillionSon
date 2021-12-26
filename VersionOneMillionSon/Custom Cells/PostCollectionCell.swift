//
//  PostCollectionCell.swift
//  VersionOneMillionSon
//
//  Created by Vincent Cubit on 11/27/21.
//


import UIKit


class PostCollectionCell: UICollectionViewCell {
    
    
    static let id = "PostCollectionCell"
    
    
    private let postImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        return image
    }()
        
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.postImage)
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 12.0
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.postImage.frame = self.contentView.bounds
    }
    
    
    public func configure(with image: UIImage) {
        self.postImage.image = image
    }
    
    
}

