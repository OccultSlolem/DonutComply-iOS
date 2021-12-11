//
//  SignInView.swift
//  DonutComply
//
//  Created by Ethan Hanlon on 12/10/21.
//

import SwiftUI
import FirebaseAuth
import AuthenticationServices

struct SignInView: View {
    // Data entry
    @State private var email = ""
    @State private var password = ""
    @State private var showingAlert = false
    // Nonce for Sign in with Apple
    @State fileprivate var currentNonce: String?
    // Navigation
    @State private var pushToLoading = false
    
    var body: some View {
        VStack {
            Group {
                // Alert handler
                Button(action: {
                        print("Show login alert")
                        
                }, label: {
                    EmptyView()
                })
                .alert(isPresented:$showingAlert, content: {
                    Alert(title: Text("Sign-in failed"), message: Text("Either the password is invalid or the account does not exist"), dismissButton: .default(Text("OK")))
                })
                .hidden()
                
                // Navigation handler
//                NavigationHandler(
//                    view: AnyView(LoadingView()
//                                    .environmentObject(UserSettings())),
//                    isActive: $pushToLoading)
            
                Text("Log In")
                    .font(.largeTitle)
                
                Text("Log in with email and password")
                    .padding()
                    
                CustomStyledTextField(text: $email, placeholder: "Email", symbolName: "person.circle.fill", isSecure: false)
                    .padding(.bottom)
                CustomStyledTextField(text: $password, placeholder: "Password", symbolName: "lock.circle.fill", isSecure: true)
                        .padding(.bottom)
                    
                CustomStyledButton(title: "Sign in with email", action: login)
                    .padding(.bottom)
            }
                
            Group {
                //Password reset button
                NavigationLink(
                    destination: Text("Hello, world!"),
                    label: {
                        Text("Forgot password?")
                            .fontWeight(.bold)
                        Image(systemName: "chevron.right")
                                .font(.caption)

                    }
                )
                
                Divider()
                
                Spacer()
                
                AppleSignInView()
                    .frame(width: 280, height: 60)
                
                Spacer()
            }
                
        }
        .navigationBarTitle(" ")
    }
    
    //Attempt to sign in with email
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if(error == nil) {
                // Push to LoadingView
                pushToLoading = true
            } else {
                // Login failed, present error
                print("Error signing in with email: \(String(describing: error))")
                showingAlert = true
            }
        }
    }
}

//Yes, the preview does look a little odd, because it doesn't include the Spacer that the NavigationView shoves in there
struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
