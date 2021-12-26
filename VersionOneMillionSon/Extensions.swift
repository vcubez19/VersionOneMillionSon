//
//  Extensions.swift
//  VersionOneMillionSon
//
//  Created by Vincent Cubit on 11/23/21.
//

import Foundation
import UIKit


extension UIViewController {
    
    
        
    func saveImage(image: UIImage, name: String){
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileName = "image-\(name).jpg"
            let fileURL = documentsDirectory.appendingPathComponent("\(fileName)")
            if let data = image.jpegData(compressionQuality:  1.0),
              !FileManager.default.fileExists(atPath: fileURL.path) {
                do {
                    try data.write(to: fileURL)
                } catch {
                    fatalError()
                }


            }

        
        
    }
    
    
    
    
    
    func getImages(images: inout [ UIImage ]) {
        
        
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        print(documentDirectory.path)
        let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
        for imageURL in directoryContents where imageURL.pathExtension == "jpg" {
            if let image = UIImage(contentsOfFile: imageURL.path) {
                images.append(image)
            } else {
               fatalError()
            }
        }
        
        
    }
    
    
    func refreshFM() {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsUrl,
                                                                       includingPropertiesForKeys: nil,
                                                                       options: .skipsHiddenFiles)
            for fileURL in fileURLs {
                if fileURL.pathExtension == "jpg" {
                    try FileManager.default.removeItem(at: fileURL)
                }
            }
        } catch  { print(error) }
    }
    
    
}


extension UITableViewCell {
    func getImages(images: inout [ UIImage ]) {
        
        
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
        for imageURL in directoryContents where imageURL.pathExtension == "jpg" {
            if let image = UIImage(contentsOfFile: imageURL.path) {
                images.append(image)
                
                print("Adding image")
            } else {
               fatalError("Can't create image from file \(imageURL)")
            }
        }
        
        
    }
    
    
    func getImageCount() -> Int {
        var count = 0
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
        for imageURL in directoryContents where imageURL.pathExtension == "jpg" {
            count += 1
        }
        
        
        return count
        
        
    }
    
    
}


var vSpinner : UIView?


extension UIViewController {
    
    
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = .white
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.color = .systemBlue
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
        
        
        
        
    }
    
    
}


