//
//  BackgroundThread.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2025-01-14.
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    func fetchData() {
        
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            
            print(Thread.isMainThread)
            print(Thread.current)
            
            DispatchQueue.main.async {
                print(Thread.isMainThread)
                print(Thread.current)
                self.dataArray = newData
            }
        }
        
    }
    
    private func downloadData() -> [String]{
        var data: [String] = []
        for x in 0..<100 {
            data.append("\(x)")
            print(data)
        }
        return data
    }
    
}


struct BackgroundThread: View {
    
    @StateObject var vm = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                Text("LOAD DATA")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundStyle(.red)
                }
            }
        }
    }
}

#Preview {
    BackgroundThread()
}
