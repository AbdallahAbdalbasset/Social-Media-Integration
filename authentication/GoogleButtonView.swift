//
//  GoogleButtonView.swift
//  authentication
//
//  Created by Macbook on 10/17/22.
//

import SwiftUI
import GoogleUtilities
import GoogleSignIn
import GoogleSignInSwift

struct GoogleButtonView: View {
    @EnvironmentObject var googleModelData: GoogleDataModel

    var body: some View {
        
        GoogleSignInButton(action: handleSignInButton)

    }
    
    func handleSignInButton() {
        let signInConfig = GIDConfiguration(clientID:"3735917829-rdi2rp22ms5o1p3i5je7fh50mfc33n1r.apps.googleusercontent.com")
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: presentingViewController ) { user, error in
            
            guard error == nil else { return }
            guard let user = user else { return }
            
            googleModelData.email = user.profile?.email ?? "Unknown email"
            
            googleModelData.name += user.profile?.name ?? "Unknown name"
            
            guard let profilePicUrl = user.profile?.imageURL(withDimension: 320) else { withAnimation {
                googleModelData.isLogged = true
            }
                return
            }
            guard let data = try? Data(contentsOf: profilePicUrl) else { withAnimation {
                googleModelData.isLogged = true
            }
                return
            }
            guard let uiImage = UIImage(data: data) else { withAnimation {
                googleModelData.isLogged = true
            }
                return
            }
            googleModelData.image = Image(uiImage: uiImage)
            withAnimation {
                googleModelData.isLogged = true
            }
            // If sign in succeeded, display the app's main content View.
            
        }
        
    }
    
}



struct GoogleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleButtonView()
    }
}
