//
//  FaceBookSignIn.swift
//  Kwiwi
//
//  Created by NULL on 10/22/22.
//

import SwiftUI
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit



struct FaceBookSignInn: UIViewRepresentable {
    
    func makeCoordinator() -> FaceBookSignInn.Coordinator {
        return FaceBookSignInn.Coordinator()
    }
    
    func makeUIView(context: UIViewRepresentableContext<FaceBookSignInn>) -> FBLoginButton {
        let button = FBLoginButton()
        button.permissions = ["email"]
        button.delegate = context.coordinator
       
        return button
    }
    func updateUIView(_ uiView: FBLoginButton, context: UIViewRepresentableContext<FaceBookSignInn> ) {
        
    }
}
class Coordinater: NSObject,LoginButtonDelegate {
  
    
    @AppStorage("logged") var logged = false
        @AppStorage("email") var email = ""
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if error != nil {
            print(error?.localizedDescription as Any)
            return
        }
        if AccessToken.current != nil {
            let credential = FacebookAuthProvider
                .credential(withAccessToken: AccessToken.current!.tokenString)
            Auth.auth().signIn(with: credential) { authResult, err in
                if  err != nil {
                    print((err?.localizedDescription)!)
                    return
                }
                print("Sucessss")
                
            }
            if !result!.isCancelled {
                logged = true
                let request = GraphRequest(graphPath: "me", parameters: ["fields": "email"])
                request.start { (_, res, _) in
                    guard let profileData = res as? [String: Any] else { return }
                    self.email = profileData["email"] as! String
                }
            }
        }
    }
        
        func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
            logged = false
            email = ""
            try! Auth.auth().signOut()
        }
        
       
    
}



















