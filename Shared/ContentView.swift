//
//  ContentView.swift
//  Shared
//
//  Created by Dustin Olsen on 2/17/21.
//

import SwiftUI

 class User: ObservableObject, Codable {
    @Published var id: String
    @Published var isActive: Bool
    @Published var name: String
    @Published var age: Int
    @Published var company: String
    @Published var email: String
    @Published var address: String
    @Published var about: String
    @Published var registered: String
    @Published var tags: [String]
    @Published var friends: [Friends]
    
    enum CodingKeys: CodingKey {
        case id, isActive, name, age, company, email, address, about, registered, tags, friends
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(isActive, forKey: .isActive)
        try container.encode(name, forKey: .name)
        try container.encode(age, forKey: .age)
        try container.encode(company, forKey: .company)
        try container.encode(email, forKey: .email)
        try container.encode(address, forKey: .address)
        try container.encode(about, forKey: .about)
        try container.encode(registered, forKey: .registered)
        try container.encode(tags, forKey: .tags)
        try container.encode(friends, forKey: .friends)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        isActive = try container.decode(Bool.self, forKey: .isActive)
        name = try container.decode(String.self, forKey: .name)
        age = try container.decode(Int.self, forKey: .age)
        company = try container.decode(String.self, forKey: .company)
        email = try container.decode(String.self, forKey: .email)
        address = try container.decode(String.self, forKey: .address)
        about = try container.decode(String.self, forKey: .about)
        registered = try container.decode(String.self, forKey: .registered)
        tags = try container.decode([String].self, forKey: .tags)
        friends = try container.decode([Friends].self, forKey: .friends)
    }
    
    
}

class UserData: ObservableObject {
    @Published var userList = [User]()
}

struct Friends: Codable, Hashable {
    var id: String
    var name: String
}

struct ContentView: View {
    
    func loadData() {
            guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
                print("Invalid URL")
                return
            }
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    do {
                        let decodedResponse = try JSONDecoder().decode([User].self, from: data)
                        print("fuck yeah - decoded")
                        DispatchQueue.main.async {
                            self.results = decodedResponse
                            print(results[0])
                        }
                        return
                    } catch let error as NSError {
                        print("Decoding failed: \(error)")
                    }
                }
            }.resume()
        }
        
    @State private var results = [User]()
    

    var body: some View {
        
        NavigationView {
            
            
            
            List(results, id: \.id) { user in
                VStack(alignment: .leading) {
                    
                    NavigationLink(destination: UserView()) {
                        Text(user.name)
                                .font(.headline)
                                .foregroundColor(user.isActive ? .green : .black)
                    }
                        
                    
                    
                    Text("Age: \(user.age)")
                    Text("Company: \(user.company)")
                        .font(.subheadline)
                    Text("Email: \(user.email)")
                        .font(.subheadline)
                    Text("Address: \(user.address)")
                        .font(.subheadline)
    //                Text(item.about)
                    Text("Member since: \(user.registered)")
                    HStack {
                        ForEach(user.tags, id: \.self) { tag in
                            Text("#\(tag)")
                        }
                    }
                    VStack {
                        ForEach(user.friends, id: \.self) { friend in
                            Text("\(friend.name)")
                        }
                    }
                    
                }
            }
            .onAppear(perform: loadData)
        }
        
        
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
