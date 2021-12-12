//
//  SettingsView.swift
//  DonutComply
//
//  Created by Ethan Hanlon on 12/10/21.
//

import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    @EnvironmentObject var session: SessionStore
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMsg = ""
    
    var body: some View {
        NavigationView {
            VStack {
                // Alert Handler
                Button(action: {
                    print("Show login alert")
                }, label: {
                    EmptyView()
                })
                    .alert(isPresented: $showingAlert, content: {
                        Alert(title: Text(alertTitle), message: Text(alertMsg), dismissButton: .default(Text("OK")))
                    })
                    .hidden()

                // MARK: - Top
                LazyVStack(alignment: .leading) {
                    switch session.session {
                    case nil:
                        Text("Hello, guest!")
                            .font(.largeTitle)
                            .fontWeight(.ultraLight)
                            .padding(.leading)
                        
                    default:
                        // Logged in
                        Text("Hello, " + (session.session?.displayName ?? "human!"))
                            .font(.largeTitle)
                            .fontWeight(.ultraLight)
                            .padding(.leading)
                            
                        // Verify email
                        LazyHStack {
                            if (session.session?.isEmailVerified) == true {
                                HStack {
                                    Image(systemName: "checkmark.circle")
                                    
                                    Text("Email verified")
                                }
                                .foregroundColor(.green)
                                .padding(.bottom)
                                .padding(.horizontal)
                            } else {
                                HStack {
                                    Image(systemName: "xmark.circle")
                                        .foregroundColor(.red)
                                    
                                    Text("Email not verified")
                                        .foregroundColor(.red)
                                    Spacer()
                                    
                                    Button(action: {
                                        session.session?.sendEmailVerification(completion: nil)
                                        
                                        alertTitle = "Verification message sent"
                                        alertMsg = "Please check your email for a verification message. Check your spam/junk folder if you can't find it in your inbox."
                                        showingAlert = true
                                    }, label: {
                                        HStack {
                                            Text("Verify Email")
                                            Image(systemName: "chevron.right")
                                        }
                                        .foregroundColor(.blue)
                                        .padding(.horizontal)
                                    })
                                }
                                
                                .padding(.bottom)
                                .padding(.horizontal)
                            }
                        }
                        .padding(.top, -15.0)

                        
                    }
                }
                
                
                Divider()
                
                // MARK: - Bottom
                // Note that the list is mirrored vertically, so
                // we have to apply FlipEffect to each
                // ListRow and define the list backwards
                List {
                    if (session.session != nil) {
                        Button(action: {
                            do {
                                try Auth.auth().signOut()
                            } catch {
                                alertTitle = "Something went wrong"
                                alertMsg = "Failed to sign out. Try again later."
                                showingAlert = true
                                return
                            }
                        }, label: {
                            ListRow(text: "Sign out", sfSymbol: "escape", bgColor: Colors.aventurine)
                        })
                            .modifier(FlipEffect())
                    } else {
                        // Sign up
                        NavigationLink(
                            destination: RegisterView().environmentObject(session),
                            label: {
                                ListRow(text: "Sign up", sfSymbol: "person.crop.circle.fill.badge.plus", bgColor: .black)
                                
                                
                                    .modifier(FlipEffect())
                            }
                        )
                        
                        // TODO: Resolve lopsidedness
                        NavigationLink(
                            destination: SignInView().environmentObject(session),
                            label: {
                                ListRow(text: "Sign in", sfSymbol: "key.fill", bgColor: .black)
                                    .modifier(FlipEffect())
                            }
                        )
                    }
                }
                .padding(.top)
                .hasScrollEnabled(false)
                .modifier(FlipEffect())
            }
            .modifier(HideNavigationBar())
        }
    }
}

extension View {
    func hasScrollEnabled(_ value: Bool) -> some View {
        self.onAppear {
            UITableView.appearance().isScrollEnabled = value
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
        SettingsView()
            .preferredColorScheme(.dark)
    }
}
