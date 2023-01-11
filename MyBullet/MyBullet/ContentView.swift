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
        if signInVM.currentUser != nil {
            VStack {
                Text("로그인 완료")
                Button("로그아웃") {
                    Task {
                        await signInVM.signOut()
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
