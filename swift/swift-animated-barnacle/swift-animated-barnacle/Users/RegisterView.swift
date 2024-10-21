//
//  RegisterView.swift
//  swift-animated-barnacle
//
//  Created by m1_air on 10/20/24.
//

import SwiftUI

struct RegisterView: View {
    @State var userService: UserService = UserService()
    @State var confirmPassword: String = ""
    @State var success: Bool = false
    
    var body: some View {
        VStack{
            Text("Register")
            
            TextField("Username", text: $userService.user.username)
                                    .tint(.black)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .padding()
            
            TextField("Email", text: $userService.user.email)
                                    .tint(.black)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .padding()
                                    
            SecureField("Password", text: $userService.user.password)
                                    .tint(.black)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .padding()
            
            SecureField("Confirm Password", text: $confirmPassword)
                                    .tint(.black)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .padding()
            
            Button("Submit", action: {
                                        Task{
                                            let registered = await userService.createNewUser()
                                            if (registered) {
                                                success = await userService.authenticateUser()
                                                if (success) {
                                                    print("User created and authenticated!")
                                                } else {
                                                    print("Error creating new user!")
                                                }
                                            }
                                        }
            }).fontWeight(.ultraLight)
                                       .foregroundColor(.black)
                                       .padding()
                                       .background(
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color.white)
                                                .shadow(color: .gray.opacity(0.4), radius: 4, x: 2, y: 2)
                                        )
        }
    }
}

#Preview {
    RegisterView()
}
