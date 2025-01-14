//
//  CodableView.swift
//  IntermediateBootcamp
//
//  Created by David Cartwright on 2025-01-14.
//

import SwiftUI

struct CustomerModel: Identifiable, Codable {
    let id: String
    let name: String
    let points: Int
    let isPremium: Bool
    
    
    //all of the following code is for encodable and decodable if these protocols are added separately instead of codable
    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case points
//        case isPremium
//    }
//    
//    init(id: String, name: String, points: Int, isPremium: Bool) {
//        self.id = id
//        self.name = name
//        self.points = points
//        self.isPremium = isPremium
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(String.self, forKey: .id)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.points = try container.decode(Int.self, forKey: .points)
//        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
//    }
//    
//    func encode(to encoder: any Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(name, forKey: .name)
//        try container.encode(points, forKey: .points)
//        try container.encode(isPremium, forKey: .isPremium)
//    }
    
}

class CodableViewModel: ObservableObject {
    
    @Published var customer: CustomerModel? = nil
    
    init() {
        getData()
    }
    
    func getData() {
        guard let data = getJSONData() else {return}
        self.customer = try? JSONDecoder().decode(CustomerModel.self, from: data)

        
//        do {
//            self.customer = try JSONDecoder().decode(CustomerModel.self, from: data)
//        } catch let error {
//            print("Error decoding: \(error)")
//        }
        
//        if
//            let localData = try? JSONSerialization.jsonObject(with: data, options: []),
//            let dictionary = localData as? [String: Any],
//            let id = dictionary["id"] as? String,
//            let name = dictionary["name"] as? String,
//            let points = dictionary["points"] as? Int,
//            let isPremium = dictionary["isPremium"] as? Bool {
//            
//            let newCustomer = CustomerModel(
//                id: id,
//                name: name,
//                points: points,
//                isPremium: isPremium
//            )
//            
//            customer = newCustomer
//            
//        }
        
    }
    
    func getJSONData() -> Data? {
        
        let customer = CustomerModel(
            id: "111",
            name: "Laura",
            points: 100,
            isPremium: true
        )
//        let dictionary: [String: Any] = [
//            "id": "12345",
//            "name": "Dave",
//            "points": 5,
//            "isPremium": false
//        ]
        
//        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        let jsonData = try? JSONEncoder().encode(customer)
        return jsonData
        
    }
    
//    CustomerModel(
//        id: "1",
//        name: "Dave",
//        points: 7,
//        isPremium: true
//    )
    
}

struct CodableView: View {
    
    @StateObject private var vm = CodableViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            if let customer = vm.customer {
                Text(customer.id)
                Text(customer.name)
                Text("\(customer.points)")
                Text("\(customer.isPremium)")
            }
        }
    }
}

#Preview {
    CodableView()
}
