//
//  AppLockView.swift
//  NetflixApp
//
//  Created by Samuel Wiatrzyk on 2024-11-26.
//

import SwiftUI

struct AppLockView: View {
    @EnvironmentObject var appLockVM: AppLockViewModel
    
    var body: some View {
        VStack(spacing: 30){
            Image(systemName: "lock")
                .font(.largeTitle)
                .foregroundColor(.red)
            Text("App Locked")
                .font(.title)
            Button("Open"){
                appLockVM.appLockValidation()
            }
            .foregroundColor(.primary)
            .padding(.horizontal, 30)
            .padding(.vertical,15)
            .background(RoundedRectangle(cornerRadius: 8).stroke(Color.black))
        }
    }
}

struct AppLockView_Previews: PreviewProvider {
    static var previews: some View {
        AppLockView()
    }
}

