//
//  authenticationApp.swift
//  authentication
//
//  Created by Macbook on 10/15/22.
//

import SwiftUI
import FBSDKCoreKit
import GoogleSignIn



@main
struct authenticationApp: App {
    @StateObject var facebookModelData = FacebookDataModel()
    @StateObject var googleModelData = GoogleDataModel()

    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(facebookModelData)
                .environmentObject(googleModelData)
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
                .onAppear {
                    GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                        // Check if `user` exists; otherwise, do something with `error`
                    }
                }
        }
    }
}
        
        
        
