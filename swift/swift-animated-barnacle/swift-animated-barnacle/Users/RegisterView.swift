//
//  RegisterView.swift
//  swift-animated-barnacle
//
//  Created by m1_air on 10/20/24.
//

import SwiftUI

struct RegisterView: View {
    @State var userVM: UserVM = UserVM()
    @State var confirmPassword: String = ""
    @State var success: Bool = false
    
    var body: some View {
        VStack{
            success ? Text("Successfully Registered. Logging In.") : Text("Register")
            
            TextField("Username", text: $userVM.user.username)
                                    .tint(.black)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .padding()
            
            TextField("Email", text: $userVM.user.email)
                                    .tint(.black)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .padding()
                                    
            SecureField("Password", text: $userVM.user.password)
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
                                            let registered = await userVM.createNewUser()
                                            if (registered) {
                                                success = await userVM.authenticateUser()
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
