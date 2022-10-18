//
//  AccountDetailsView.swift
//  authentication
//
//  Created by Macbook on 10/17/22.
//

import SwiftUI
import FBSDKLoginKit
import GoogleSignIn
import GoogleSignInSwift
import GoogleUtilities

struct AccountDetailsView: View {
    @EnvironmentObject var facebookModelData: FacebookDataModel
    @EnvironmentObject var googleModelData: GoogleDataModel
    let identifier: Bool
    var body: some View {
        
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            
            VStack {
                VStack {
                    if identifier {
                        facebookModelData.image
                            .resizable()

                    }
                    else {
                        googleModelData.image
                            .resizable()

                    }
                }
                .frame(width: 300, height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 3)
                        .fill(Color.black.opacity(0.3))
                }
                .padding()
                Text(identifier ? facebookModelData.name: googleModelData.name)
                    .padding()
                Text(identifier ? facebookModelData.email: googleModelData.email)
                    .padding()
                Button {
                    if identifier {
                        facebookModelData.isLogged = false
                        facebookModelData.manager.logOut()
                        facebookModelData.email = ""
                        facebookModelData.name = ""
                        facebookModelData.image = Image(systemName: "photo")
                    }
                    else {
                        googleModelData.isLogged = false
                        googleModelData.email = ""
                        googleModelData.name = ""
                        googleModelData.image = Image(systemName: "photo")
                        GIDSignIn.sharedInstance.signOut()
                    }
                    
                    
                    
                    
                }label: {
                    HStack {
                        Spacer()
                        Text("Log out")
                            .font(.title)
                            .padding(.horizontal)
                            .background(.black.opacity(0.2))
                            .clipShape(Capsule())
                            .foregroundColor(.black.opacity(0.8))
                        Spacer()
                    }
                    .padding()
                    
                }
            }
            .background(.ultraThickMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 5)
            .padding()
            
        }
        
    }
}

