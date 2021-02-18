//
//  ContentView.swift
//  Shared
//
//  Created by Dustin Olsen on 2/17/21.
//

import SwiftUI

struct User: Codable {
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: String
    var tags: [String]
    var friends: [Friends]
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
                        print("fuck yeah, we decoded")
                        
                        DispatchQueue.main.async {
                            self.results = decodedResponse
                        }
                        return
                    } catch let error as NSError {
                        print("Decoding failed: \(error)")
                    }
                }
//                print("Fetch failed: \(error?.localizedDescription ?? "Unknown Error")")
            }.resume()
        }
        
    @State private var results = [User]()
//    @State private var friendList = [Friends]()
    
    var body: some View {
        
        Text("")
        List(results, id: \.id) { item in
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                    .foregroundColor(item.isActive ? .green : .black)
                Text("Age: \(item.age)")
                Text("Company: \(item.company)")
                    .font(.subheadline)
                Text("Email: \(item.email)")
                    .font(.subheadline)
                Text("Address: \(item.address)")
                    .font(.subheadline)
//                Text(item.about)
                Text("Member since: \(item.registered)")
                HStack {
                    ForEach(item.tags, id: \.self) { tag in
                        Text("#\(tag)")
                    }
                }
                VStack {
                    ForEach(item.friends, id: \.self) { friend in
                        Text("\(friend.name)")
                    }
                }
                
            }
        }
        .onAppear(perform: loadData)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
