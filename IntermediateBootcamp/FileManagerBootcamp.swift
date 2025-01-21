//
//  FileManagerBootcamp.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2025-01-21.
//

import SwiftUI

class LocalFileManager {
    static let shared = LocalFileManager()
    
    private init () {}
    
    func saveImage(image: UIImage, name: String) {
        guard let data = image.pngData() else {
            print("error getting data")
            return
        }
        
        
        let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        let path = directory?.appendingPathComponent("\(name).png")
        
        print(directory)
        print(path)
    }
    
    
}

@Observable class FileManagerViewModel {
    var image: UIImage? = nil
    let imageName: String = "code"
    let manager = LocalFileManager.shared
    
    init() {
        getImageFromAssetsFolder()
    }
    
    func getImageFromAssetsFolder() {
        image = UIImage(named: imageName)
    }
    
    func saveImage() {
        guard let image else {return}
        manager.saveImage(image: image, name: imageName)
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

                
                Spacer()
            }
            .navigationTitle("File Manager")
        }
    }
}

#Preview {
    FileManagerBootcamp()
}
