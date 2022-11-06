//
//  GoogleSignInApp.swift
//  Kwiwi
//
//  Created by NULL on 10/22/22.
//

import SwiftUI
import Firebase
import GoogleSignIn


@main
struct KwiwiApp: App {
    
  
    // concting appdelegte
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
   
  
}

class AppDelegate:  UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
       
       
       
                
        //Intilaizinh Firebase
      
       
        return true
    }
 func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any])
      -> Bool {
        
  
      return GIDSignIn.sharedInstance.handle(url)
    }
   
        }

















