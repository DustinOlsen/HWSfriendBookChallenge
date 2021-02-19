//
//  UserView.swift
//  HWSfriendBookChallenge
//
//  Created by Dustin Olsen on 2/19/21.
//

import SwiftUI

struct UserView: View {
    
    @ObservedObject var userData = UserData()
    
    
    
    
    
    var body: some View {
        
        List(userData.userList, id: \.id) { user in
            VStack {
                Text(user.name)
            }
        }
        
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
