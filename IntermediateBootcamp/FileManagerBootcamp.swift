//
//  FileManagerBootcamp.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2025-01-21.
//

import SwiftUI

class LocalFileManager {
    static let shared = LocalFileManager()
    let folderName = "MyApp_Images"
    
    private init () {
        createFolderIfNeeded()
    }
    
    func createFolderIfNeeded() {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask).first?
                .appendingPathComponent("MyApp_Images")
                .path
        else {
            return
        }
        //if the path doesn't exist
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                print("success creating folder")
            } catch let error {
                print("error creating folder: \(error)")
            }
        }
    }
    
    func deleteFolder() {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask).first?
                .appendingPathComponent("MyApp_Images")
        else {
            return
        }
        
        do {
            try FileManager.default.removeItem(at: path)
            print("success deleting folder")
        } catch let error {
            print(error)
        }
    }
    
    func saveImage(image: UIImage, name: String) -> String {
        guard
            let data = image.pngData(),
            let path = getPathForImage(name: name)
        else {
            print("error getting data")
            return "error getting data"
        }
        
        do {
            try data.write(to: path)
            print(path)
            return "success saving"
        } catch let error {
            print("error saving: \(error.localizedDescription)")
            return "error saving \(error)"
        }
    }
    
    func getImage(name: String) -> UIImage? {
        guard let path = getPathForImage(name: name)?.path,
              FileManager.default.fileExists(atPath: path)
        else {
            print("error getting path")
            return nil
        }
        return UIImage(contentsOfFile: path)
    }
    
    func deleteImage(name: String) -> String {
        guard let path = getPathForImage(name: name),
              FileManager.default.fileExists(atPath: path.path)
        else {
            print("error getting path for deletion")
            return "error getting path"
        }
        
        do {
            try FileManager.default.removeItem(at: path)
            print("successfully deleted")
            return "successfully deleted"
        } catch let error {
            print("error deleting: \(error)")
            return "error deleting: \(error)"
        }
    }
    
    func getPathForImage(name: String) -> URL? {
        guard let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask).first?
            .appending(path: folderName)
            .appendingPathComponent("\(name).png")
        else {
            print("error getting path")
            return nil
        }
        return path
    }
    
}

@Observable class FileManagerViewModel {
    var image: UIImage? = nil
    let imageName: String = "code"
    let manager = LocalFileManager.shared
    var infoMessage: String = ""
    
    init() {
                getImageFromAssetsFolder()
//        getImageFromFileManager()
    }
    
    func getImageFromAssetsFolder() {
        image = UIImage(named: imageName)
    }
    
    func getImageFromFileManager() {
        image = manager.getImage(name: imageName)
    }
    
    func saveImage() {
        guard let image else {return}
        infoMessage = manager.saveImage(image: image, name: imageName)
        
    }
    
    func deleteImage() {
        infoMessage = manager.deleteImage(name: imageName)
        manager.deleteFolder()
    }
}


struct FileManagerBootcamp: View {
    
    @State private var vm = FileManagerViewModel()
    
    var body: some View {
        NavigationStack {
            
            VStack {
                
                if let image = vm.image {
                    
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                HStack {
                    Button {
                        vm.saveImage()
                    } label: {
                        Text("Save to FM")
                            .foregroundStyle(.white)
                            .padding()
                            .padding(.horizontal)
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding()
                            .shadow(radius: 10)
                    }
                    
                    Button {
                        vm.deleteImage()
                    } label: {
                        Text("Delete from FM")
                            .foregroundStyle(.white)
                            .padding()
                            .padding(.horizontal)
                            .background(.red)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding()
                            .shadow(radius: 10)
                    }
                }
                
                Text(vm.infoMessage)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(.purple)
                
                
                Spacer()
            }
            .navigationTitle("File Manager")
        }
    }
}

#Preview {
    FileManagerBootcamp()
}
