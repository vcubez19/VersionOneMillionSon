//
//  EditPhotosViewController.swift
//  CollectionHeader
//
//  Created by Vincent Cubit on 11/18/21.
//


import UIKit


import UIKit
import Photos
import PhotosUI
//import SPIndicator


final class PhotosViewController: UIViewController {
    
    
    // MARK: UI Elements
    
    
    private let collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .systemBackground
        collection.register(AddNewImagesCollectionCells.self, forCellWithReuseIdentifier: AddNewImagesCollectionCells.id)
        collection.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.id)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    
    let customLabel = UILabel()
    let spImage = UIImage.init(systemName: "exclamationmark.icloud")!.withTintColor(.systemOrange, renderingMode: .alwaysOriginal)
    let flexibleSpace = UIBarButtonItem(systemItem: .flexibleSpace)
    let trash = UIBarButtonItem(systemItem: .trash)
    let add = UIBarButtonItem(systemItem: .add)
    
    
    // MARK: Data
    var images: [ UIImage ] = []
    
    
    // MARK: Other Variables
    var exitLoop = false
    var isEditingImages: Bool = false
        
    
    // MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.getImages(images: &self.images)
        
        
        self.view.backgroundColor = .systemBackground
        
        
        self.view.addSubview(self.collection)
        
            
        
        self.collection.delegate = self
        self.collection.dataSource = self
        
        
        let next = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(method))
        self.navigationItem.rightBarButtonItem = next
        
        
        self.trash.isEnabled = false
        self.trash.tintColor = .systemBackground
        self.trash.target = self
        self.trash.action = #selector(self.didTapDelete)
        self.toolbarItems = [ editButtonItem, self.flexibleSpace, self.trash, self.flexibleSpace, self.add ]
        self.navigationController?.isToolbarHidden = false
        
        
        self.add.target = self
        self.add.action = #selector(self.addPhotos)
        
        
        let longPressGesture = UILongPressGestureRecognizer(target: self,
                                                            action: #selector(self.handleGesture(_:)))
        self.collection.addGestureRecognizer(longPressGesture)
        
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        
        
        let constraints: [ NSLayoutConstraint ] = [
        
            self.collection.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40),
            self.collection.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.collection.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            self.collection.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
        ]
        NSLayoutConstraint.activate(constraints)
        

        
    }
    
    
    // MARK: Methods
    
    
    @objc func addPhotos() {
        var configPicker = PHPickerConfiguration(photoLibrary: .shared())
        configPicker.selectionLimit = 12
        configPicker.filter = .images
        let vc = PHPickerViewController(configuration: configPicker)
        vc.delegate = self
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true) {
            if self.isEditing {
                self.isEditing = false
                self.trash.isEnabled = false
                self.trash.tintColor = .systemBackground
            }
        }
    }
    
    
    @objc private func didTapDelete() {
        
        
        if let selectedCells = self.collection.indexPathsForSelectedItems {
        
            let items = selectedCells.map { $0.item }.sorted().reversed()
            for item in items {
                self.images.remove(at: item)
            }
            self.collection.deleteItems(at: selectedCells)
            self.trash.isEnabled = false
            self.trash.tintColor = .systemBackground
            self.collection.reloadData()
            
        }
        
        
    }
    
    
    @objc private func handleGesture(_ gesture: UILongPressGestureRecognizer) {
        
                
        switch gesture.state {
        
        case .began:
            guard let targetPath = self.collection.indexPathForItem(at: gesture.location(in: self.collection)) else { return }
            self.collection.beginInteractiveMovementForItem(at: targetPath)
        case .changed:
            self.collection.updateInteractiveMovementTargetPosition(gesture.location(in: self.collection))
        case .ended:
            self.collection.endInteractiveMovement()
        default:
            self.collection.cancelInteractiveMovement()
        
        }
        
        
    }
    
    
    // MARK: Editing
    override func setEditing(_ editing: Bool, animated: Bool) {
        
        
        
        if self.images.count != 0 {
            self.collection.indexPathsForVisibleItems.forEach { (IndexPath) in
                let cell = self.collection.cellForItem(at: IndexPath) as? PhotoCell
                cell?.number.text = String( IndexPath.row + 1 )
            }
        }
        
        
        if editing {
            self.trash.tintColor = .systemBlue
            self.trash.isEnabled = true
        } else {
            self.trash.tintColor = .systemBackground
            self.trash.isEnabled = false
        }
        
        
        if editing {
            self.title = "Press and hold to move items"
        } else {
            self.title = "Item photos"
        }
        
        
        super.setEditing(editing, animated: true)
        self.collection.allowsMultipleSelection = editing
        self.collection.indexPathsForSelectedItems?.forEach({ (IndexPath) in
            self.collection.deselectItem(at: IndexPath, animated: true)
        })
        
        
        self.collection.indexPathsForVisibleItems.forEach { (IndexPath) in
            let cell = collection.cellForItem(at: IndexPath) as? PhotoCell
            cell?.isEditing = editing
        }
        
        
    }
    
    
    // Segue
    

}


// MARK: PHPicker
extension PhotosViewController: PHPickerViewControllerDelegate {
    
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
    
        
        dismiss(animated: true)
        let group = DispatchGroup()
        var max = false
        
        
        var count = 0
        results.forEach { result in
            group.enter()
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] reading, error in
                defer {
                    group.leave()
                }
                
                
                guard let image = reading as? UIImage, error == nil else {
                    return
                }
                
                
                count += 1
                if( self?.images.count)! < 12 {
                    //self?.images.append(image)
                    self?.saveImage(image: image, withName: "image-\(count).jpg", time: Date())
                } else {
                    max = true
                }
                
                
            }
            
            
        }
        
        
        // Main thread
        group.notify(queue: .main) {
            if max {
                //SPIndicator.present(title: "Maximum met", message: "Edit if needed", preset: .custom(self.spImage))
                print("Max")
            }
            
            self.collection.reloadData()
            
            
        }

        
    }
    
    
}


// MARK: Collection View
extension PhotosViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.images.count == 0 {
            return 2
        } else {
            return self.images.count
        }
        
    }
    
    
    // MARK: cellForItem
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            

        if self.images.count > 0 {
            self.editButtonItem.isEnabled = true
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.id, for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
            

            cell.imageView.image = self.images[indexPath.row]
            cell.number.text = String( indexPath.row + 1 )
            cell.isEditing = isEditing
            
            
            return cell
            
            
        } else {
            self.isEditing = false
            self.editButtonItem.isEnabled = false
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddNewImagesCollectionCells.id, for: indexPath) as? AddNewImagesCollectionCells else { return UICollectionViewCell() }
            
            
            if indexPath.row == 0 {
                cell.configureCell(with: "Take photos", image: "camera", color: .systemTeal)
            } else {
                cell.configureCell(with: "Select photos", image: "plus", color: .systemBlue)
            }
            
            
            return cell

            
        }


    }
    
    
    // Select
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if self.images.count > 0 {
            
            
            if !isEditing {
                self.trash.isEnabled = false
                self.trash.tintColor = .systemBackground
                //self.performSegue(withIdentifier: "PhotoSetupDetail", sender: cell)
                
            } else {
                
                self.trash.isEnabled = true
                self.trash.tintColor = .systemBlue
                
            }
            
            
        } else {
            if indexPath.row == 1 {
                self.addPhotos()
                
            }
        }
        
        
    }
    
    
    // Deselect
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        
        if let selectedItems = collectionView.indexPathsForSelectedItems, selectedItems.count == 0 {
            self.trash.isEnabled = false
            self.trash.tintColor = .systemBackground
        }
        
        
    }
    
    
    // MARK: Move items
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        
        if isEditing && self.images.count > 0 {
            return true
        } else {
            return false
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if self.images.count != 0 {
            let item = self.images.remove(at: sourceIndexPath.row)
            self.images.insert(item, at: destinationIndexPath.row)
            collectionView.reloadData()
        }
    }
    
    
    // Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
            let noOfCellsInRow = 3
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        
            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        
            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

        
        if self.images.count != 0 {
            if indexPath.row == 0 {
                return CGSize(width: collectionView.frame.size.width, height: collection.frame.size.width / 2.0)
            } else {
                return CGSize(width: size, height: size)
            }
        } else {
            return CGSize(width: size, height: size)
        }
            
            

    }


}

