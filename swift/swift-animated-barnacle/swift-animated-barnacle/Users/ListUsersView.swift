//
//  ListUsersView.swift
//  swift-animated-barnacle
//
//  Created by m1_air on 10/22/24.
//

import SwiftUI

struct ListUsersView: View {
    
    @State var userService: UserService = UserService()
    @State var gotUser: Bool = false
    @State var gotUsers: Bool = false
    @State var error: String = ""
    
    var body: some View {
        VStack{
            Text("Welcome \(userService.user.username)")
            ScrollView {
                ForEach(userService.users, id: \._id) { user in
                    if user._id != (userService.user._id ?? "") {
                                    GroupBox(content: {
                                        HStack{
                                            Text(user.username)
                                            Spacer()
                                            Button(action: {
                                                Task{
                                                    await userService.deleteUser(byId: user._id ?? "")
                                                }
                                            }, label: {
                                                Image(systemName: "trash")
                                            })
                                        }
                                    }).padding()
                                }
                            }
                        }
        }.onAppear{
            guard let user_id = UserDefaults.standard.string(forKey: "user_id") else {
                self.error = "Error: No token found."
                return
            }
            Task{
                gotUser = await userService.fetchUser(byId: user_id)
                gotUsers = await userService.fetchAllUsers()
            }
        }
    }
}

#Preview {
    ListUsersView()
}
