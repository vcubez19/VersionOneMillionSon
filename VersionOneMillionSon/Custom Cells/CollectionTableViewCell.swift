//
//  CollectionTableViewCell.swift
//  VersionOneMillionSon
//
//  Created by Vincent Cubit on 11/27/21.
//


import UIKit


class CollectionTableViewCell: UITableViewCell {

    
    static let id = "CollectionTableViewCell"
    
    
    private let pageControlReference = DetailTableViewCell()
    
    
    private let collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(PostCollectionCell.self, forCellWithReuseIdentifier: PostCollectionCell.id)
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectionCell")
        collection.backgroundColor = .systemBackground
        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    
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
    
    
    var images: [ UIImage ] = [  ]
    private var liked: Bool = false

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        self.contentView.addSubview(self.collection)
        self.contentView.addSubview(self.likeButton)
        self.contentView.addSubview(self.pageControl)
        self.likeButton.addTarget(self, action: #selector(self.like), for: .touchUpInside)
        self.likeButton.imageEdgeInsets = UIEdgeInsets(top: 24.0, left: 40.0, bottom: 24.0, right: 40.0)
        self.collection.delegate = self
        self.collection.dataSource = self
        
        
        self.getImages(images: &self.images)
        self.pageControl.numberOfPages = self.images.count


        

        let constraints: [NSLayoutConstraint] = [
            self.collection.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.collection.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.collection.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.collection.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -80),
            self.likeButton.leftAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leftAnchor),
            self.likeButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -35),
            self.likeButton.heightAnchor.constraint(equalToConstant: 24.0),
            self.likeButton.widthAnchor.constraint(equalToConstant: 40.0),
            self.pageControl.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor, constant: -21),
            self.pageControl.centerXAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.centerXAnchor),


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
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    

}


extension CollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collection.dequeueReusableCell(withReuseIdentifier: PostCollectionCell.id,
                                                        for: indexPath) as? PostCollectionCell else { return UICollectionViewCell() }
        cell.configure(with: self.images[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.contentView.frame.size.width, height: self.contentView.frame.size.height - 80)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    
    
    
}

