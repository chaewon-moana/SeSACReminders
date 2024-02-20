//
//  FileManager+Extension.swift
//  SeSACReminders
//
//  Created by cho on 2/19/24.
//

import UIKit

extension UIViewController {
    func loadImageFromDocument(fileName: String) -> UIImage? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return UIImage(systemName: "star")!}
        let fileURL = documentDirectory.appendingPathComponent("\(fileName).png")
        if FileManager.default.fileExists(atPath: fileURL.path()) {
            return UIImage(contentsOfFile: fileURL.path())!
        } else {
            return UIImage(systemName: "star.fill")!
        }

    }
    
    func saveImageToDocument(image: UIImage, fileName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = documentDirectory.appendingPathComponent("\(fileName).png")
        guard let data = image.pngData() else { return }
        
        do {
            try data.write(to: fileURL)
        } catch {
            print("file save error", error)
        }
    }
}
