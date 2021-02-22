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

class UserData: ObservableObject {
    @Published var userList = [User]()
}

struct Friends: Codable, Hashable {
    var id: String
    var name: String
}

public class SelectedUser {
    internal init(id: String, isActive: Bool, name: String, age: Int, company: String, email: String, address: String, about: String, registered: String, tags: [String], friends: [Friends]) {
        self.id = id
        self.isActive = isActive
        self.name = name
        self.age = age
        self.company = company
        self.email = email
        self.address = address
        self.about = about
        self.registered = registered
        self.tags = tags
        self.friends = friends
    }
    
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
    
//    init() {}
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
                        }
                        return
                    } catch let error as NSError {
                        print("Decoding failed: \(error)")
                    }
                }
            }.resume()
        }
    
    
    @State private var results = [User]()
    @State public var selected = SelectedUser(
        id: "",
        isActive: false,
        name: "",
        age: 0,
        company: "",
        email: "",
        address: "",
        about: "",
        registered: "",
        tags: [""],
        friends: [Friends]()
    )
    
    
    var body: some View {
        
        NavigationView {
            
            List(results, id: \.id) { user in
                VStack(alignment: .leading) {

                    Button("") {
                        selected = SelectedUser(
                            id: user.id,
                            isActive: user.isActive,
                            name: user.name,
                            age: user.age,
                            company: user.company,
                            email: user.email,
                            address: user.address,
                            about: user.about,
                            registered: user.registered,
                            tags: user.tags,
                            friends: user.friends
                        )
                        print(selected.name)
                    }
                    
                    NavigationLink(destination: UserView(selected: selected)) {
                        Text(user.name)
                                .font(.headline)
                                .foregroundColor(user.isActive ? .green : .black)
                    }

                    Text("Company: \(user.company)")
                        .font(.subheadline)
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
