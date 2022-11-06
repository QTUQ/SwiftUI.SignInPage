//
//  ContentView.swift
//  Kwiwi
//
//  Created by NULL on 10/20/22.
//
import Foundation
import SwiftUI
import Firebase
import GoogleSignIn
import UIKit

struct ContentView: View {
    @AppStorage("log_Status") var log_Status = false
    var body: some View {
        
        if log_Status{
            
            NavigationView {
                VStack(spacing: 15) {
                    Text("Logged In")
                    Button("Logout") {
                        GIDSignIn.sharedInstance.signOut()
                        try? Auth.auth().signOut()
                        withAnimation {
                            log_Status = false
                        }
                    }
                }
            }
            
        } else {
            SignInPage()
        }
        

          
                
            
            
        }
       
    }
















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


