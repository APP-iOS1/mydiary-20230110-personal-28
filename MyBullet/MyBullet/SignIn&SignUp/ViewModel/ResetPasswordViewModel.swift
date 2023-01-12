//
//  ResetPasswordViewModel.swift
//  MyBullet
//
//  Created by Roen White on 2023/01/11.
//

import Foundation

class ResetPasswordViewModel {
    var resetPasswordResponse: ResetPasswordResponse = ResetPasswordResponse()
    
    let authStore: AuthStore = AuthStore()
    
    // MARK: Reset password Method
    func resetPassword(emailID: String) async {
        let result: ResetPasswordResponse = await authStore.resetPassword(emailID: emailID)
        
        self.resetPasswordResponse = result
    }
}
