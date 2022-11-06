//
//  SignInPage.swift
//  Kwiwi
//
//  Created by NULL on 10/21/22.
//

import SwiftUI
import AuthenticationServices
import Firebase
struct SignInPage: View {
    
    @State var isLoading: Bool = false
    var body: some View {
        VStack() {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.teal, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                VStack (spacing: 60){
                   Spacer()
                    Text("Sign In")
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                        .padding(.bottom, 30)
               
                    VStack(alignment: .center, spacing: 15){
                        SignInWithApple()
                        SignInWithGoogle(image: Image("gog"), text: ("Sign In With Google"))
                        
                    }
                    .padding(.trailing)
                    Spacer()
                    Divider()
                    Spacer()
                    VStack{
                        Text("You are completetly safe.")
                        Link(destination: URL(string: "https://instagram.com/fajrestate?igshid=NmNmNjAwNzg=")!) {
                            Text("Read our Terms and Conditions.")
                                .foregroundColor(.red)
                            
                        }
                      
                    }
                }
                .padding()
                
            }
        }
        .overlay(
            ZStack{
                if isLoading{
                    Color.black
                        .opacity(0.25)
                        .ignoresSafeArea()
                    ProgressView()
                        .font(.title2)
                        .frame(width: 40, height: 60)
                        .background(Color.white)
                        .cornerRadius(10)
                }
            }
        )
        }
       
    }
struct SignInPage_Previews: PreviewProvider {
    static var previews: some View {
        SignInPage()
    }
}

struct SignInWithGoogle: View {
    let google = HandleSignIn()
    var image: Image
    var text: String
    
    var body: some View {
        
        ZStack{
           
            Button(text) {
                google.signInWithGoogle()
            }
            
            .padding()
            .frame(width: 273)
            .foregroundColor(.red)
            .font(.title2)
            .background(Color(.white))
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
            
        }
        .padding(.horizontal)
        image
            .resizable()
            .frame(width: 20, height: 20)
            .cornerRadius(10)
            .padding(.trailing, 220)
            .offset(y: -55)
    }
}

struct SignInWithApple: View {
    @State private var currentNonce:String?
    var body: some View {
        SignInWithAppleButton(.continue,
                              onRequest: { request in
            let nonce = AuthFile.randomNonceString()
            currentNonce = nonce
            request.requestedScopes = [.fullName, .email]
            request.nonce = AuthFile.sha256(nonce)
        },
        onCompletion: { result in
            switch result {
                
            case .success(let authResults):
                switch authResults.credential {
                case let appleIDCredential as ASAuthorizationAppleIDCredential:
                    
                    guard let nonce = currentNonce else {
                        fatalError("Invalid state: A login callback was received, but no login request was sent.")
                    }
                    guard let appleIDToken = appleIDCredential.identityToken else {
                        fatalError("Invalid state: A login callback was received, but no login request was sent.")
                    }
                    guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                        print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                        return
                    }
                    
                    let credential = OAuthProvider.credential(withProviderID: "apple.com",idToken: idTokenString,rawNonce: nonce)
                    Auth.auth().signIn(with: credential) { (authResult, error) in
                        if (error != nil) {
                            print(error?.localizedDescription as Any)
                            return
                        }
                        print("signed in")
                    }
                    
                    print("\(String(describing: Auth.auth().currentUser?.uid))")
                default:
                    break
                    
                }
            default:
                break
                
                
            }     }
        )
        
        .padding()
        .frame(width: 300, height:  90)
        .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
        .padding(.horizontal)
    }
}
