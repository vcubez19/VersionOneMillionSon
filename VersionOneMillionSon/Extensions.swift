//
//  Extensions.swift
//  VersionOneMillionSon
//
//  Created by Vincent Cubit on 11/23/21.
//

import Foundation
import UIKit


extension UIViewController {
    
    
    func saveImage(image: UIImage, withName name: String, time: Date) {

        
        var date = Date()
        date = time
        let imageData = NSData(data: image.jpegData(compressionQuality: 0.7)!)
       let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,  FileManager.SearchPathDomainMask.userDomainMask, true)
       let docs = paths[0] as NSString
        print(docs)
       let name = name + NSUUID().uuidString + ".jpg"
       let fullPath = docs.appendingPathComponent(name)
       _ = imageData.write(toFile: fullPath, atomically: true)
        
        
   }
    
    
    func getImages(images: inout [ UIImage ]) {
        
        
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
        for imageURL in directoryContents where imageURL.pathExtension == "jpg" {
            if let image = UIImage(contentsOfFile: imageURL.path) {
                images.append(image)
            } else {
               fatalError("Can't create image from file \(imageURL)")
            }
        }
        
        
        // get names of images in array == whats in array
        // get last ones index + 1 order by number
        
        
    }
    
    
}

