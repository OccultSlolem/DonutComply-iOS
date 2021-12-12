//
//  AuthHelper.swift
//  DonutComply
//
//  Created by Ethan Hanlon on 12/10/21.
//

import Foundation
import Combine
import CryptoKit
import Firebase

struct AuthHelper {
    /**
    * Generates nonce that is used for Sign in with Apple
    * This is used to prevent replay attacks
    * Make sure to pass a SHA256 hash of this nonce to the request's nonce parameter
    */
    static func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
              Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
             randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
            
        }
        return result
    }
    
    /// Returns a SHA256 hash of whatever string you put in
    @available(iOS 13, *)
    static func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()

        
        return hashString
    }
    
    /**
     * Sets the user profile photo. Note that this is the FireAuth profile photo - only the current user will be able to see it.
     * completionHandler will be called with a true boolean if successful; false otherwise
     */
    static func setUserProfilePhoto(photoURL: URL, completionHandler: @escaping (Bool) -> Void) {
        guard let user = Auth.auth().currentUser else {
            // FAIL, No user
            completionHandler(false)
            return
            
        }
        let userChangeRequest = user.createProfileChangeRequest()
        userChangeRequest.photoURL = photoURL
        userChangeRequest.commitChanges() { error in
            if error != nil {
                // FAIL
                completionHandler(false)
            } else {
                // SUCCESS
                completionHandler(true)
            }
        }
    }
}

public class SessionStore: ObservableObject {
    @Published var session = Auth.auth().currentUser {  // Note: Optional value
        didSet {
            self.didChange.send(self)
        }
    }
    var didChange = PassthroughSubject<SessionStore, Never>()
    var handle: AuthStateDidChangeListenerHandle?
    
    func listen() {
        // Monitor auth changes
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                // Signed in!
                self.session = user
            } else {
                self.session = nil
            }
        }
    }
}
