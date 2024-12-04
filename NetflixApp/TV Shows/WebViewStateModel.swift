//
//  WebViewStateModel.swift
//  NetflixApp
//
//  Created by Samuel Wiatrzyk on 2023-07-21.
//

import Foundation

class WebViewStateModel: ObservableObject{
    @Published var pageTitle:String = "http://10.0.0.174:8888"
    @Published var goToPage:Bool = false
    
    @Published var goBack:Bool = false
    @Published var goForward:Bool = false
}
