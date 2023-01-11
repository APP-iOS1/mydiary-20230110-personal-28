//
//  SignInViewModel.swift
//  MyBullet
//
//  Created by Roen White on 2023/01/11.
//

import Foundation
import FirebaseAuth

class SignInViewModel: ObservableObject {
    @Published var authResponse: AuthResponse = AuthResponse()
    
    var currentUser: User? {
        authResponse.currentUser
    }
    
    init() {
        authResponse.currentUser = Auth.auth().currentUser
    }
    
    let authStore = AuthStore()
    
    @MainActor
    func signUpAndSetNickname(emailID: String, password: String, nickname: String) async {
        var result: AuthResponse = await authStore.signUp(emailID: emailID, password: password)
        result = await authStore.signIn(emailID: emailID, password: password)
        await authStore.changeDisplayName(nickname: nickname)
        
        self.authResponse = result
    }
    
    func signIn(emailID: String, password: String) async {
        let result: AuthResponse = await authStore.signIn(emailID: emailID, password: password)
        
        self.authResponse = result
    }
}
