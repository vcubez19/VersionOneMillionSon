//
//  FirstViewController.swift
//  VersionOneMillionSon
//
//  Created by Vincent Cubit on 12/4/21.
//


import UIKit


class FirstViewController: UIViewController {
    
    
    private let collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 15.0, bottom: 0.0, right: 15.0)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(PostCollectionCell.self, forCellWithReuseIdentifier: PostCollectionCell.id)
        collection.backgroundColor = .systemBackground
        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.currentPageIndicatorTintColor = .systemBlue
        pc.pageIndicatorTintColor = .systemGray2
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    
    private let postButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("New Post", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 20.0
        button.layer.masksToBounds = true
        return button
    }()
    
    
    private var images: [ UIImage ] = []
    
    
    override func viewDidLoad() {
        self.title = "Post"
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(self.collection)
        self.view.addSubview(self.pageControl)
        self.view.addSubview(self.postButton)
        self.collection.delegate = self
        self.collection.dataSource = self
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barTintColor = .systemBackground
        
        
        
        self.postButton.addTarget(self, action: #selector(self.didClickPostNew), for: .touchUpInside)
        
        
        self.images = [
            UIImage(named: "catt.jpg")!,
            UIImage(named: "dog.jpg")!,
            UIImage(named: "lizard.jpg")!
        ]
        
        
        let constraints: [ NSLayoutConstraint ] = [
            self.collection.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collection.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.collection.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor, constant: -self.view.frame.size.height / 3.0),
            self.collection.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            self.pageControl.topAnchor.constraint(equalTo: self.collection.layoutMarginsGuide.bottomAnchor, constant: -40.0),
            self.pageControl.centerXAnchor.constraint(equalTo: self.view.layoutMarginsGuide.centerXAnchor),
            self.postButton.topAnchor.constraint(equalTo: self.pageControl.bottomAnchor, constant: 70.0),
            self.postButton.leftAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leftAnchor, constant: 40.0),
            self.postButton.rightAnchor.constraint(equalTo: self.view.layoutMarginsGuide.rightAnchor, constant: -40.0),
            self.postButton.heightAnchor.constraint(equalToConstant: 50.0)

        ]
        NSLayoutConstraint.activate(constraints)
        
        
        self.pageControl.numberOfPages = self.images.count

        
        
    }
    
    
    @objc func didClickPostNew() {
        let vc = ViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    


}


extension FirstViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collection.dequeueReusableCell(withReuseIdentifier: PostCollectionCell.id,
                                                        for: indexPath) as? PostCollectionCell else { return UICollectionViewCell() }
        cell.configure(with: self.images[indexPath.row])
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collection.bounds.width - 30.0, height: collection.bounds.height - 100.0)
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30.0
    }
    
    
    
    
}

