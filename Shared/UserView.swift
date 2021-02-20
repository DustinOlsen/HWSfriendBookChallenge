//
//  UserView.swift
//  HWSfriendBookChallenge
//
//  Created by Dustin Olsen on 2/19/21.
//

import SwiftUI

struct UserView: View {
    
    var selected: SelectedUser

    var body: some View {
        
        Text(selected.name)
        Text("\(selected.age)")
        Text("Company: \(selected.company)")
        
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        let user = SelectedUser(
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
            friends: [Friends]())
        UserView(selected: user)
    }
}
