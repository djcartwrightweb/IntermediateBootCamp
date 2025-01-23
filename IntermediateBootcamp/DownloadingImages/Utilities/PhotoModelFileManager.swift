//
//  PhotoModelFileManager.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2025-01-23.
//

import Foundation
import SwiftUI

class PhotoModelFileManager {
    static let shared = PhotoModelFileManager()
    let folderName = "downloaded_photos"
    
    private init () {
        createFolderIfNeeded()
    }
    
    private func createFolderIfNeeded() {
        guard let url = getFolderPath() else { return }
        
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
                print("created folder!")
            } catch let error {
                print("error creating folder: \(error)")
            }
        }
    }
    
    private func getFolderPath() -> URL? {
        return FileManager.default.urls(
            for: .cachesDirectory,
            in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName, conformingTo: .folder)
    }
    
    private func getImagePath(key: String) -> URL? {
        guard let folder = getFolderPath() else {
            return nil
        }
        return folder.appendingPathComponent(key + "png", conformingTo: .png)
    }
    
    func add(key: String, value: UIImage) {
        guard let data = value.pngData(),
              let url = getImagePath(key: key)
        else {
            return
        }
        
        do {
            try data.write(to: url)
        } catch let error {
            print("error saving to file manager \(error)")
        }
    }
    
    func get(key: String) -> UIImage? {
        guard let url = getImagePath(key: key),
              FileManager.default.fileExists(atPath: url.path)
        else {
            return nil
        }
        
        return UIImage(contentsOfFile: url.path)
    }
}
