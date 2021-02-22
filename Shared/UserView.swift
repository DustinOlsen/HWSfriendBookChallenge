//
//  UserView.swift
//  HWSfriendBookChallenge
//
//  Created by Dustin Olsen on 2/19/21.
//

import SwiftUI

struct UserView: View {
    
    var selected: SelectedUser
    @State var userTags = [String]()

    var body: some View {

        VStack(alignment: .leading) {
                
            Text("Member Since: \(selected.registered)")
            Text("Works for: \(selected.company)")
            Section(header: Text("Contact Info:")) {
                Text(selected.email)
                Text("Address: \(selected.address)")
                
            }
                Section(header: Text("About:")) {
                    Text(selected.about)
                    Spacer()
                    
                    
                    HStack {
                        ForEach(selected.tags, id: \.self) {
                            Text("#\($0)")
                            
                        }
                    }
                }
        }
            

        .navigationBarTitle(selected.name).font(.headline)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        let user = SelectedUser(
            id: "",
            isActive: false,
            name: "John Lemon",
            age: 0,
            company: "Big Dick inc.",
            email: "BigDong@thedong.com",
            address: "2020 Lemon Ave, Minneapolis, MN",
            about: "About user's life story",
            registered: "month/day/year",
            tags: ["tags, tags, moretags"],
            friends: [Friends]())

            UserView(selected: user)
    }
}
