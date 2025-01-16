//
//  SubscriberBootcamp2.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2025-01-16.
//

import SwiftUI

@Observable class SubscriberBootcamp2ViewModel {
    
    var textFieldText: String = ""
    
}

struct SubscriberBootcamp2: View {
    
    @Bindable var vm: SubscriberBootcamp2ViewModel = SubscriberBootcamp2ViewModel()
    
    var body: some View {
        TextField("type something...", text: $vm.textFieldText)
    }
}

#Preview {
    SubscriberBootcamp2()
}
