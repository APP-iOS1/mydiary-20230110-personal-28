//
//  ResetPasswordView.swift
//  MyBullet
//
//  Created by Roen White on 2023/01/11.
//

import SwiftUI

struct ResetPasswordView: View {
    let resetPWVM: ResetPasswordViewModel = ResetPasswordViewModel()
    
    // MARK: User Details
    @State private var emailID: String = ""
    
    // MARK: View Properties
    @Environment(\.dismiss) var dismiss
    @State private var showSuccessToast: Bool = false
    @State private var showFailToast: Bool = false
    @State private var toastMessage: String = ""
    @State private var isLoading: Bool = false
    
    private var validEmail: Bool {
        String().isValidEmail(emailID)
    }
    
    var body: some View {
        VStack(spacing: 30) {
            VStack(alignment: .leading) {
                Image(systemName: "highlighter").font(.largeTitle)
                (Text("마이불렛")
                    .foregroundColor(.accentColor) +
                 Text(" 회원가입")
                )
                .font(.title)
                .fontWeight(.semibold)
                .padding(.top)
            }
            .hAlign(.leading)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("이메일 아이디")
                    Spacer()
                    if !emailID.isEmpty && validEmail {
                        Text("\(Image(systemName: "exclamationmark.triangle")) 잘못된 이메일 형식 입니다.")
                            .foregroundColor(.gray)
                            .font(.callout)
                    }
                }
                
                HStack {
                    TextField("이메일 주소를 입력하세요.", text: $emailID)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                }
                Rectangle()
                  .frame(height: 1)
                  .foregroundColor(.gray)
            }
            .padding(.top, 15)
            
            Button {
                isLoading = true
                Task {
                    await resetPWVM.resetPassword(emailID: emailID)
                    toastMessage = resetPWVM.resetPasswordResponse.message
                    if resetPWVM.resetPasswordResponse.isSuccessed {
                        showSuccessToast.toggle()
                    } else {
                        showFailToast.toggle()
                    }
                    isLoading = false
                }
            } label: {
                Text("메일 보내기")
                    .foregroundColor(.white)
                    .font(.title3)
                    .bold()
                    .hAlign(.center)
                    .padding(.vertical, 10)
            }
            .buttonStyle(.borderedProminent)
            .tint(.accentColor)
            .disabled(validEmail)
            Spacer()
            
            Spacer()
            HStack {
                Text("비밀번호가 생각났어요!")
                    .foregroundColor(.gray)
                
                Button {
                    dismiss()
                } label: {
                    Text("로그인")
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                }
            }
        }
        .padding(30)
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
