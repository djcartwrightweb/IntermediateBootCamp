//
//  ArrayView.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2024-12-11.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID()
    let name: String
    let points: Int
    let isVerified: Bool
}

@Observable class ArrayViewModel {
    
    var dataArray: [UserModel] = []
    var filteredArray: [UserModel] = []
    var mappedArray: [String] = []
    
    init() {
        self.getUsers()
        self.updateFilteredArray()
    }
    
    func updateFilteredArray() {
        //sort, filter, map
        
//        filteredArray = dataArray.sorted { $0.points < $1.points }
//        filteredArray = dataArray.filter {$0.isVerified}
        mappedArray = dataArray.map {$0.name}
        
    }
    
    func getUsers() {
        let user1 = UserModel(name: "Dave", points: 10, isVerified: true)
        let user2 = UserModel(name: "Laura", points: 12, isVerified: false)
        let user3 = UserModel(name: "Peyton", points: 2, isVerified: true)
        let user4 = UserModel(name: "Isla", points: 24, isVerified: false)
        let user5 = UserModel(name: "Kisses", points: 13, isVerified: true)
        let user6 = UserModel(name: "Bella", points: 1, isVerified: true)
        let user7 = UserModel(name: "Lady", points: 9, isVerified: true)
        let user8 = UserModel(name: "Lou-Dog", points: 7, isVerified: false)
        let user9 = UserModel(name: "Turbo", points: 33, isVerified: true)
        dataArray.append(contentsOf: [
            user1,
            user2,
            user3,
            user4,
            user5,
            user6,
            user7,
            user8,
            user9,
        ])
    }
    
}

struct ArrayView: View {
    
    var vm = ArrayViewModel()
    
    var body: some View {
        
        
        ScrollView {
            VStack(spacing: 20) {
                ForEach(vm.mappedArray, id: \.self) {item in
                    Text(item)
                }
                
                
//                ForEach(vm.filteredArray) { user in
//                    VStack(alignment: .leading) {
//                        Text(user.name)
//                            .font(.headline)
//                        HStack {
//                            Text("Points: \(user.points)")
//                                
//                            Spacer()
//                            if user.isVerified {
//                                Image(systemName: "flame.fill")
//                            }
//                        }
//                    }
//                    .foregroundStyle(.white)
//                    .padding()
//                    .background(Color.blue)
//                    .clipShape(RoundedRectangle(cornerRadius: 10))
//                    .padding(.horizontal)
//                }
            }
            
        }
    }
}

#Preview {
    ArrayView()
}
