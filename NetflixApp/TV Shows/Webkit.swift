//
//  Webkit.swift
//  NetflixApp
//
//  Created by Samuel Wiatrzyk on 2023-07-21.
//

import SwiftUI

struct Webkit: View {
    @ObservedObject var webViewStateModel:WebViewStateModel = WebViewStateModel()
    @State private var webAddress = "http://10.0.0.174:8888"
    var body: some View {
        VStack{
           HStack{
                TextField("Enter Web /Address",text: $webAddress)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.gray)
                .cornerRadius(25)
              Button(action: {
                   webViewStateModel.pageTitle = webAddress
                   webViewStateModel.goToPage = true
               }, label: {
                 Image(systemName: "magnifyingglass.circle.fill")
            })
                .font(.title)
            }
            WKView(webViewStateModel: webViewStateModel)
            
        }
        .toolbar{
            ToolbarItem(placement: ToolbarItemPlacement.bottomBar){
                HStack{
                    Button(action: {
                        webViewStateModel.goBack = true
                    }, label: {
                        Image(systemName: "arrow.backward")
                    })
                    Button(action: {
                        webViewStateModel.goForward = true
                    }, label: {
                        Image(systemName: "arrow.forward")
                    })
                }
            }
        }
    }
}

struct Webkit_Previews: PreviewProvider {
    static var previews: some View {
        Webkit()
    }
}
