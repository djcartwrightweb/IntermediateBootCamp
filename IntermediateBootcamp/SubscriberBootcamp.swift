//
//  SubscriberBootcamp.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2025-01-16.
//

import SwiftUI
import Combine

class SubscriberViewModel: ObservableObject {
    
    @Published var count: Int = 0
    var cancellables = Set<AnyCancellable>()
    
    @Published var textFieldText: String = ""
    @Published var textIsValid: Bool = false
    
    @Published var showButton: Bool = false
    
    init() {
        setUpTimer()
        addTextFieldSubscriber()
        addButtonSubscriber()
    }
    
    func addTextFieldSubscriber() {
        $textFieldText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main) //waits until done typing for specified amount of time
            .map { (text) -> Bool in
                text.count > 3 ? true : false
            }
//            .assign(to: \.textIsValid, on: self)
            .sink(receiveValue: { [weak self] isValid in
                self?.textIsValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func setUpTimer() {
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: { [weak self] _ in
                //this next line prevents from having to use self? (see code below)
                guard let self = self else { return }
                self.count += 1
            })
            .store(in: &cancellables)
        
//            .sink { [weak self] _ in
//                self?.count += 1
//                if let count = self?.count, count >= 10 {
//                    self?.timer?.cancel()
//                }
//            }
    }
    
    func addButtonSubscriber() {
        $textIsValid
            .combineLatest($count)
            .sink { [weak self] isValid, count in
                guard let self = self else {return}
                if isValid && count >= 10 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }
    
}

struct SubscriberBootcamp: View {
    
    @StateObject var vm = SubscriberViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.count)")
                .font(.largeTitle)
            
            TextField("Type something here...", text: $vm.textFieldText)
                .padding()
                .frame(height: 55)
                .background(Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(alignment: .trailing) {
                    ZStack {
                        Image(systemName: "xmark")
                            .foregroundStyle(.red)
                            .opacity(
                                vm.textFieldText.count < 1 ? 0 :
                                vm.textIsValid ? 0 : 1)
                        
                        Image(systemName: "checkmark")
                            .foregroundStyle(.green)
                            .opacity(vm.textIsValid ? 1 : 0)
                    }
                    .font(.title2)
                    .padding()
                }
            Button {
                //
            } label: {
                Text("Submit".uppercased())
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .opacity(vm.showButton ? 1 : 0.5)
            }
            .disabled(!vm.showButton)

            
        }
        .padding()
    }
}

#Preview {
    SubscriberBootcamp()
}
