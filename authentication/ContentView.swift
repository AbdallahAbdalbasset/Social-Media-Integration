//
//  ContentView.swift
//  authentication
//
//  Created by Macbook on 10/15/22.
//

import SwiftUI
import FBSDKLoginKit

struct ContentView: View {
    @EnvironmentObject var facebookModelData: FacebookDataModel
    @EnvironmentObject var googleModelData: GoogleDataModel

    
    var body: some View {
        
        NavigationView {
            
            if facebookModelData.isLogged {
                
                AccountDetailsView(identifier: true)
                    .navigationBarTitle("Facebook info")
                
            }
            else if googleModelData.isLogged {
                AccountDetailsView(identifier: false)
                    .navigationBarTitle("Google info")


            }
            else  {
                ZStack {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                    VStack {
                        
                        Text("Sign in using social media!")
                            .font(.title.bold())
                            .foregroundColor(.blue.opacity(0.8))
                        Image("socialmedia")
                            .resizable()
                            .frame(width: 400, height: 300)
                            .padding()
                            .clipShape(Circle())
                        Spacer()
                        Divider()
                        
                        Text("Log In")
                            .font(.title)
                            .foregroundColor(.blue)
                        
                        
                        FacebookButtonView()
                            .padding()
                        
                        GoogleButtonView()
                            .font(.title)
                            .padding(.horizontal, 83)
                        
                        Spacer()
                        
                    }
                }

 
            }
        }
        
    }
}

