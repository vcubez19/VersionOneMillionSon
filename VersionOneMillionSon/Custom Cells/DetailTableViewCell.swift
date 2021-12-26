//
//  DetailTableViewCell.swift
//  VersionOneMillionSon
//
//  Created by Vincent Cubit on 11/27/21.
//


import UIKit


class DetailTableViewCell: UITableViewCell {

    
    static let id = "DetailTableViewCell"
    
    
    private let likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.imageView?.clipsToBounds = true
        button.imageView?.layer.masksToBounds = true
        button.tintColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.currentPageIndicatorTintColor = .systemBlue
        pc.pageIndicatorTintColor = .systemGray2
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    
    private var liked: Bool = false
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.likeButton)
        self.likeButton.addTarget(self, action: #selector(self.like), for: .touchUpInside)
        self.likeButton.imageEdgeInsets = UIEdgeInsets(top: 24.0, left: 40.0, bottom: 24.0, right: 40.0)
        self.contentView.addSubview(self.pageControl)
        //self.pageControl.numberOfPages = self.getImageCount()
                
        
        let constraints: [NSLayoutConstraint] = [
            self.likeButton.leftAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leftAnchor),
            self.likeButton.centerYAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.centerYAnchor),
            self.likeButton.heightAnchor.constraint(equalToConstant: 24.0),
            self.likeButton.widthAnchor.constraint(equalToConstant: 40.0),
            self.pageControl.centerXAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.centerXAnchor),
            self.pageControl.centerYAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.centerYAnchor)


        ]
        NSLayoutConstraint.activate(constraints)
        
        
    }
    
    
    @objc private func like() {
        self.liked.toggle()
        if self.liked {
            self.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            self.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    public func sendPageControl() -> UIPageControl {
        return self.pageControl
    }

    
}

