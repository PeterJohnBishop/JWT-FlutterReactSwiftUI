//
//  LoginView.swift
//  swift-animated-barnacle
//
//  Created by m1_air on 10/20/24.
//

import SwiftUI

struct LoginView: View {
    @State var userService: UserService = UserService()
    @State var success: Bool = false
    
    var body: some View {
        VStack{
            Text("Login")
            
            TextField("Username", text: $userService.user.username)
                                    .tint(.black)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .padding()
                                    
            SecureField("Password", text: $userService.user.password)
                                    .tint(.black)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .padding()
            
            Button("Submit", action: {
                                        Task{
                                            success = await userService.authenticateUser()
                                            if (success) {
                                                print("User authenticated!")
                                            } else {
                                                print("Error logging in!")
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
    LoginView()
}
