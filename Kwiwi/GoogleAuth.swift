//
//  handleSignIn.swift
//  Kwiwi
//
//  Created by NULL on 10/21/22.
//

import Foundation
import SwiftUI
import Firebase
import GoogleSignIn


struct HandleSignIn {
    @State var isLoading: Bool = false
    @AppStorage("log_Status") var log_Status = false
    
    
    func signInWithGoogle() {
        // google sign in
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        isLoading = true
        GIDSignIn.sharedInstance.signIn(with: config, presenting: getRootViewController()) {[self] user, err in
            
            if let error = err {
                isLoading = false
                print(error.localizedDescription)
                return
            }
            
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                isLoading = false
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            //fifrebase auth
            Auth.auth().signIn(with: credential) { result, err in
                isLoading = false
                if let error = err {
                    print(error.localizedDescription)
                    return
                }
                //displaying user name
                guard let user = result?.user else {
                    return
                }
                print(user.displayName ?? "Success!")
                // update user as logged in
                withAnimation {
                    log_Status = true
                }
            }
            
        }
        GIDSignIn.sharedInstance.signOut()
        try? Auth.auth().signOut()
    }
        
    
    func getRootViewController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        return root
    }

}


