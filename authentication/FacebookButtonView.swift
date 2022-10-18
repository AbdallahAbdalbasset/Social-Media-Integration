//
//  FacebookButtonView.swift
//  
//
//  Created by Macbook on 10/17/22.
//

import SwiftUI
import FBSDKLoginKit

struct FacebookButtonView: View {
    @EnvironmentObject var facebookModelData: FacebookDataModel

    var body: some View {
        
        VStack {
            
            Button{
                
                facebookModelData.manager.logIn(permissions: ["public_profile", "email"], from: nil) { result, error in
                    
                    if error != nil {
                        print(error!.localizedDescription)
                        return
                    }
                    
                    if !result!.isCancelled {
                        
                        let request = GraphRequest(graphPath: "me", parameters: ["fields": "email,name,picture.width(300).height(300)"])
                        
                        request.start { _, res, _ in
                            
                            guard let profileData = res as? [String : Any] else { return }
                            facebookModelData.email = profileData["email"] as? String ?? "Unknown email"
                            facebookModelData.name = profileData["name"] as? String ?? "Unknown name"
                            let pictureInfo = profileData["picture"] as! NSDictionary
                            guard let data = pictureInfo["data"] as! NSDictionary? else { withAnimation{ facebookModelData.isLogged = true }; return }
                            guard let urlString = data["url"] as! String? else { withAnimation{ facebookModelData.isLogged = true }; return }
                            
                            do {
                                guard let url = URL(string: urlString) else { withAnimation{ facebookModelData.isLogged = true }; return}
                                let imageData = try Data(contentsOf: url)
                                guard let uiImage = UIImage(data: imageData) else { withAnimation{ facebookModelData.isLogged = true }; return }
                                facebookModelData.image = Image(uiImage: uiImage)
                                withAnimation{ facebookModelData.isLogged = true }
                            }
                            catch{
                                withAnimation{ facebookModelData.isLogged = true }
                                print("Error loading the image")
                                return
                            }
                            
                        }
                        
                    }
                }
                
            } label: {
                
                Label("Continue with Facebook", systemImage:"f.square.fill")
                    .padding(10)
                    .foregroundColor(.white)
                    .background(.blue.opacity(0.8))
                    .font(.title3)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                
            }
            
            
        }
    }
}

struct FacebookButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FacebookButtonView()
    }
}

