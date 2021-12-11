//
//  AppleSignInView.swift
//  DonutComply
//
//  Created by Ethan Hanlon on 12/10/21.
//

import SwiftUI
import AuthenticationServices
import FirebaseAuth

struct AppleSignInView: View {
    @State fileprivate var currentNonce: String?
    private var osTheme: UIUserInterfaceStyle {
        return UIScreen.main.traitCollection.userInterfaceStyle
    }
    private var style: SignInWithAppleButton.Style {
        if osTheme == UIUserInterfaceStyle.light {
            return SignInWithAppleButton.Style.black
        } else {
            return SignInWithAppleButton.Style.white
        }
    }
    // Navigation
    @State private var pushToLoading = false
    
    var body: some View {
        VStack {
            // Navigation
//            NavigationHandler(view: AnyView(LoadingView()), isActive: $pushToLoading)
            
            SignInWithAppleButton(
                onRequest: { request in
                    // Get user email
                    request.requestedScopes = [.email]
                    
                    currentNonce = AuthHelper.randomNonceString()
                    request.nonce = AuthHelper.sha256(currentNonce!)
                },
                onCompletion: { result in
                    switch result {
                    case .success(let authResults):
                        if let appleIDCredential = authResults.credential as? ASAuthorizationAppleIDCredential {
                            guard let nonce = currentNonce else {
                                // If no nonce was defined, there can't be a login request that was sent
                                fatalError("Invalid state: A login callback was received, but no login request was sent")
                            }
                            guard let appleIDToken = appleIDCredential.identityToken else {
                                print("Unable to fetch identity token")
                                return
                            }
                            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                                return
                            }
                            
                            // If there were no errors, initialize a Firebase Credential
                            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
                            
                            // Sign in with Firebase
                            Auth.auth().signIn(with: credential) { _, error in
                                if (error != nil) {
                                    //Error
                                    print(error?.localizedDescription as Any)
                                    return
                                }
                                
                                // TODO: Assign login behavior
                                pushToLoading = true
                            }
                            
                        }
                    case .failure(let error):
                        print("Failure signing in with Apple: " + error.localizedDescription)
                    }
                }
            )
            .signInWithAppleButtonStyle(style)
        }
        
    }
}
