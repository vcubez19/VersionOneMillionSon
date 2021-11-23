//
//  EditablePhotoCollectionViewCell.swift
//  CollectionHeader
//
//  Created by Vincent Cubit on 11/18/21.
//


import UIKit


class PhotoCell: UICollectionViewCell {
    
    
    static let id = "EditablePhotoCollectionViewCell"
    
    
    // MARK: UI Elements
    let imageView: UIImageView = UIImageView()
    let numberView: UIView = UIView()
    var number: UILabel = UILabel()
    let selectedCell: UIImageView = UIImageView()
    
    
    // MARK: Initialization
    override init(frame: CGRect ) {
        super.init(frame: frame)
        
        self.addSubview(self.imageView)
        self.addSubview(self.numberView)
        self.numberView.addSubview(self.number)
        self.addSubview(self.selectedCell)
        self.numberView.backgroundColor = .systemBlue
        self.number.textColor = .white
        self.selectedCell.image = UIImage(systemName: "circle")
        self.selectedCell.tintColor = .white
        self.selectedCell.clipsToBounds = true
        self.selectedCell.backgroundColor = .white
        self.selectedCell.layer.masksToBounds = true
        self.selectedCell.layer.cornerRadius = 15
        self.selectedCell.isHidden = true
        
        
    }
    
    
    // MARK: isEditing
    var isEditing: Bool = false {
            didSet {

                self.selectedCell.isHidden = !isEditing
                self.numberView.isHidden = isEditing
                
            }


    }
    
    
    // MARK: IsSelected
    override var isSelected: Bool {
        didSet {
            if isEditing {
                if isSelected {
                    self.selectedCell.image = UIImage(systemName: "checkmark.circle")
                    self.selectedCell.backgroundColor = .systemBlue
                    self.alpha = 0.7
                } else {
                    self.selectedCell.image = UIImage(systemName: "circle")
                    self.selectedCell.backgroundColor = .white
                    self.alpha = 1.0
                }
                
                
            }
            
            
        }
        
        
    }
    
    
    // MARK: Other Methods
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    // MARK: Layout Subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.frame = contentView.bounds
        self.numberView.frame = CGRect(x: 0, y: self.contentView.frame.size.height - 30, width: 30, height: 30)
        self.number.frame = CGRect(x: 10, y: 0, width: 20, height: 30)
        self.selectedCell.frame = CGRect(x: self.contentView.frame.size.width - 35, y: self.contentView.frame.size.height - 35, width: 30, height: 30)
        
        
    }
    
    
}

