//
//  RegisterView.swift
//  DonutComply
//
//  Created by Ethan Hanlon on 12/10/21.
//

import SwiftUI
import FirebaseAuth
import FirebaseStorage
import AuthenticationServices

struct RegisterView: View {
    // Data entry
    @State private var email = ""
    @State private var password = ""
    @State private var passwordConfirm = ""
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMsg = ""
    
    // Sign in with Apple
    @State fileprivate var currentNonce: String?
    
    // Dark/light mode
    private var osTheme: UIUserInterfaceStyle {
        return UIScreen.main.traitCollection.userInterfaceStyle
    }
    
    //Navigation
    @State private var pushToOnboarding = false
    
    
    var body: some View {
        VStack {
//            NavigationHandler(view: AnyView(OnboardingBioView()), isActive: $pushToOnboarding)
            
            Group {
                //Alert handler
                Button(action: {
                        print("Show login alert")

                }, label: {
                    EmptyView()
                })
                .alert(isPresented: $showingAlert, content: {
                    Alert(title: Text(alertTitle), message: Text(alertMsg), dismissButton: .default(Text("OK")))
                })
                .hidden()
            }
            
            Group {
                Text("Register")
                    .font(.largeTitle)
                
                Text("Register with email and password")
                    .padding()
                
                CustomStyledTextField(text: $email, placeholder: "Email", symbolName: "person.circle.fill", isSecure: false)
                    .padding(.bottom)
                CustomStyledTextField(text: $password, placeholder: "Password", symbolName: "lock.circle.fill", isSecure: true)
                    .padding(.bottom)
                CustomStyledTextField(text: $passwordConfirm, placeholder: "Confirm Password", symbolName: "lock.circle.fill", isSecure: true)
                    .padding(.bottom)
                
                CustomStyledButton(title: "Register with email", action: register)
                    .padding()
                
                //Terms/privacy
                HStack {
                    
                    Link("Terms", destination: URL(string: "https://www.example.com")!)
                    
                    Text("•")
                        .foregroundColor(Colors.textForegroundColor)
                    
                    Link("Privacy", destination: URL(string: "https://www.example.com")!)
                    
                }
                .padding(.top)
                Divider()
                
                Spacer()
            }
                
            Group {
                AppleSignInView()
                    .frame(width: 280, height: 60)
                
                Spacer()
            }

        }
        .navigationBarTitle(" ")
    }
    
    func register() {
        //Check for email
        if(isValidEmail(email)) {
            //Check for min password length & matching
            if(password.count >= 8) {
                //Check for passwords matching
                if(password == passwordConfirm) {
                    Auth.auth().createUser(withEmail: email, password: password) {authResult,error in
                        guard let user = authResult?.user, error == nil else {
                            alertTitle = "Failed to create user"
                            alertMsg = error!.localizedDescription
                            showingAlert = true
                            return
                        }
                        
//                        Analytics.logEvent(AnalyticsEventSignUp, parameters: [
//                                            AnalyticsParameterMethod: EmailPasswordAuthSignInMethod
//                        ])
                        
                        alertTitle = "Welcome to Politifi!"
                        alertMsg = "Please check your email for a confirmation message. In the meantime, start out by setting your display name. We hope you enjoy your time here!"
                        showingAlert = true
                        
                        user.sendEmailVerification(completion: nil)
//                        pushToOnboarding = true
                        
                        
                    }
                } else {
                    alertTitle = "Passwords don't match"
                    alertMsg = "The passwords fields do not match with each other."
                    showingAlert = true
                }
            } else {
                alertTitle = "Password not long enough"
                alertTitle = "Your password must be at least 8 characters."
                showingAlert = true
            }
        } else {
            alertTitle = "Please enter an email address"
            alertMsg = "Either the email field was left empty, or a valid email was not entered."
            showingAlert = true
        }
    }
    
    //With thanks to Maxim Shoustin on StackOverflow
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

}

//Yes, the preview does look a little odd, because it doesn't include the Spacer that the NavigationView shoves in there
struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
