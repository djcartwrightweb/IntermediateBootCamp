//
//  WeakSelf.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2025-01-14.
//

import SwiftUI

struct WeakSelf: View {
    
    @AppStorage("count") var count: Int?
    
    init() {
        count = 0
    }
    
    var body: some View {
//        NavigationStack {
        NavigationView {
            NavigationLink {
                WeakSelfSecondScreen()
            } label: {
                Text("Navigate")
            }
            .navigationTitle("Screen 1")

        }
        .overlay(
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .padding()
                .background(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 10)),
            alignment: .topTrailing
        )
    }
}

struct WeakSelfSecondScreen: View {
    
    @StateObject var vm = WeakSelfSecondScreenViewModel()
    
    var body: some View {
        VStack {
            Text("Second View")
                .font(.largeTitle)
                .foregroundStyle(.red)
            
            if let data = vm.data {
                Text(data)
            }
        }
    }
}

class WeakSelfSecondScreenViewModel: ObservableObject {
    @Published var data: String?
    
    init() {
        print("*** INITIALIZE NOW ***")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1, forKey: "count")
        getData()
    }
    
    deinit {
        print("*** DEINITIALIZE NOW ***")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount - 1, forKey: "count")
    }
    
    func getData() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 500) { [weak self] in
            self?.data = "New Data!!!"
        }
        
    }
}

#Preview {
    WeakSelf()
}
