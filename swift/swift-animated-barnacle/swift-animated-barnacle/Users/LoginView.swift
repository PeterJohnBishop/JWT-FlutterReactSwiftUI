//
//  LoginView.swift
//  swift-animated-barnacle
//
//  Created by m1_air on 10/20/24.
//

import SwiftUI

struct LoginView: View {
    @State var userVM: UserVM = UserVM()
    @State var success: Bool = false
    
    var body: some View {
        VStack{
            success ? Text("Successfully Logged In") : Text("Login")
            
            TextField("Username", text: $userVM.user.username)
                                    .tint(.black)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .padding()
                                    
            SecureField("Password", text: $userVM.user.password)
                                    .tint(.black)
                                    .autocapitalization(.none)
                                    .disableAutocorrection(true)
                                    .padding()
            
            Button("Submit", action: {
                                        Task{
                                            success = await userVM.authenticateUser()
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
