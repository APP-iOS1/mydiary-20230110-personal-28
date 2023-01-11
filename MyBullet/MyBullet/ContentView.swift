//
//  ContentView.swift
//  MyBullet
//
//  Created by Roen White on 2023/01/11.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var signInVM: SignInViewModel
    
    var body: some View {
        if signInVM.authResponse.currentUser != nil {
            VStack {
                Text(signInVM.authResponse.currentUser?.displayName ?? "닉네임없음")
                Button("로그아웃") {
                    Task {
                        await signInVM.authStore.signOut()
                    }
                }
            }
        } else {
            SignInView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
