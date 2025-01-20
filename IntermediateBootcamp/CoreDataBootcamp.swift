//
//  CoreDataBootcamp.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2025-01-20.
//

import SwiftUI
import CoreData

class CoreDataBootcampViewModel: ObservableObject {
    
    @Published var savedEntities: [FruitEntity] = []
    
    let container: NSPersistentContainer
    
    init() {
        self.container = NSPersistentContainer(name: "FruitsContainer")
        self.container.loadPersistentStores { description, error in
            if let error {
                print("error loading core data \(error.localizedDescription)")
            } else {
                print("successfully loaded core data")
            }
        }
        fetchFruits()
    }
    
    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("error fetching: \(error.localizedDescription)")
        }
    }
    
    func addFruit(name: String) {
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = name
        saveData()
    }
    
    func deleteFruit(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
    }
    
    func updateFruit(_ fruit: FruitEntity) {
        let currentName = fruit.name ?? ""
        let newName = currentName + "!"
        fruit.name = newName
        saveData()
    }
    
    private func saveData() {
        do {
            try container.viewContext.save()
            fetchFruits()
        } catch let error {
            print("error saving: \(error.localizedDescription)")
        }
    }
}

struct CoreDataBootcamp: View {
    
    @StateObject private var vm = CoreDataBootcampViewModel()
    @State var textFieldText: String = ""
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("Add fruit here", text: $textFieldText)
                    .padding(.leading)
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                    .padding(.top)
                
                Button {
                    guard !textFieldText.isEmpty else { return }
                    vm.addFruit(name: textFieldText)
                    textFieldText = ""
                } label: {
                   Text("Save")
                    .font(.title2)
                    .foregroundStyle(Color.white)
                    .bold()
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.mint)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                }
                
                
                List {
                    ForEach(vm.savedEntities) { fruit in
                        Text(fruit.name ?? "")
                            .onTapGesture {
                                vm.updateFruit(fruit)
                            }
                    }
                    .onDelete(perform: vm.deleteFruit)
                }
                .listStyle(.plain)
                
                Spacer()
            }
            .navigationTitle("Fruits")
        }
    }
}

#Preview {
    CoreDataBootcamp()
}
