//
//  EscapingClosures.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2025-01-14.
//

import SwiftUI

class EscapingClosuresViewModel: ObservableObject {
    @Published var text: String = "Hello"
    
    func getData() {
        downloadData5 { [weak self] result in
            self?.text = result.data
        }
    }
    
    func downloadData() -> String {
        return "New data 1"
    }
    
    func downloadData2(completionHandler: (_ data: String) -> ()) {
        completionHandler("New Data 2")
    }
    
    func downloadData3(completionHandler: @escaping (_ data: String) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completionHandler("New Data 3")
        }
    }
    
    func downloadData4(completionHandler: @escaping (DownloadResult) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let result = DownloadResult(data: "New Data 4")
            completionHandler(result)
        }
    }
    
    func downloadData5(completionHandler: @escaping DownloadCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let result = DownloadResult(data: "New Data 5")
            completionHandler(result)
        }
    }
}

struct DownloadResult {
    let data: String
}

typealias DownloadCompletion = (DownloadResult) -> ()


struct EscapingClosures: View {
    
    @StateObject var vm = EscapingClosuresViewModel()
    
    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundStyle(.blue)
            .onTapGesture {
                vm.getData()
            }
    }
}

#Preview {
    EscapingClosures()
}
