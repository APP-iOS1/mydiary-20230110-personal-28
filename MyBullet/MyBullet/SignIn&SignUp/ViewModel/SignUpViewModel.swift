//
//  SignUpViewModel.swift
//  MyBullet
//
//  Created by Roen White on 2023/01/11.
//

import Foundation

class SignUpViewModel {
    var duplicatedResponse: DuplicatedResponse = DuplicatedResponse()
    
    let authStore: AuthStore = AuthStore()
    
    func checkDuplicateEmail(emailID: String) async {
        let result: DuplicatedResponse = await authStore.checkDuplicatedEmail(emailID: emailID)
        
        self.duplicatedResponse = result
    }
}
