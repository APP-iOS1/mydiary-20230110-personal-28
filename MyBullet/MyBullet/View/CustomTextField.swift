//
//  CustomTextField.swift
//  MyBullet
//
//  Created by Roen White on 2023/01/10.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var emailID: String
    @Binding var password: String
    
    // MARK: View Properties
    @FocusState var isEnabled: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            TextField("이메일 아이디", text: $emailID)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .focused($isEnabled)
            
            SecureField("비밀번호", text: $password)
                .textContentType(.password)
            
            ZStack(alignment: .leading) {
                
            }
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
