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
    
    private let authStore = AuthStore()
    
    @MainActor
    func signUpAndSetNickname(emailID: String, password: String, nickname: String) async {
        var result: AuthResponse = await authStore.signUp(emailID: emailID, password: password)
        result = await authStore.signIn(emailID: emailID, password: password)
        result.message = "회원가입이 완료되었습니다."
        
        await authStore.changeDisplayName(nickname: nickname)
        
        self.authResponse = result
    }
    
    @MainActor
    func signIn(emailID: String, password: String) async {
        let result: AuthResponse = await authStore.signIn(emailID: emailID, password: password)
        
        self.authResponse = result
    }
    
    @MainActor
    func signOut() async {
        let result: AuthResponse = await authStore.signOut()
        
        self.authResponse = result
    }
}
