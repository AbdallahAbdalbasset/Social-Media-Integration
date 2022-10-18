//
//  DataModel.swift
//  authentication
//
//  Created by Macbook on 10/16/22.
//

import Foundation
import FBSDKLoginKit
import SwiftUI

class FacebookDataModel: ObservableObject {
    
    @Published var isLogged = false
    var manager = LoginManager()
    var email = ""
    var name = ""
    var image = Image(systemName: "photo")
    
}

class GoogleDataModel: ObservableObject {
    
    @Published var isLogged = false
    var email = ""
    var name = ""
    var image = Image(systemName: "photo")
    
}
