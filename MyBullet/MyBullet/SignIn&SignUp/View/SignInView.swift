//
//  SignIn.swift
//  MyBullet
//
//  Created by Roen White on 2023/01/10.
//

import SwiftUI

struct SignInView: View {
    
    @EnvironmentObject var signInVM: SignInViewModel
    
    // MARK: User Details
    @State private var emailID: String = ""
    @State private var password: String = ""
    
    // MARK: View Properties
    @State private var createAccount: Bool = false
    @State private var resetPassword: Bool = false
    @State private var showToast: Bool = false
    @State private var toastMessage: String = ""
    @State private var isLoading: Bool = false
    
    private var activeButton: Bool {
        emailID.isEmpty || password.isEmpty
    }
    
    var body: some View {
        VStack(spacing: 10) {
            VStack(alignment: .leading) {
                Image(systemName: "highlighter").font(.largeTitle)
                (Text("일상을 기록하다.")
                    .foregroundColor(.gray) +
                 Text("\n마이불렛")
                    .foregroundColor(.accentColor) +
                 Text(" 입니다.")
                )
                .font(.title)
                .fontWeight(.semibold)
                .lineSpacing(10)
                .padding(.top, 5)
            }
            .hAlign(.leading)
            
            VStack(alignment: .leading) {
                Text("아이디")
                TextField("이메일 아이디", text: $emailID)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                Rectangle()
                  .frame(height: 1)
                  .foregroundColor(.gray)
                Spacer()
                Text("비밀번호")
                SecureField("비밀번호", text: $password)
                    .textContentType(.password)
                Rectangle()
                  .frame(height: 1)
                  .foregroundColor(.gray)
            }
            .font(.title3)
            .hAlign(.leading)
            .padding(.top, 15)
            .frame(height: 180)
            
            // TODO: 비밀번호 재설정 뷰 필요
            Button("비밀번호를 잊어버리셨나요?", action: { resetPassword.toggle() })
                .fontWeight(.medium)
                .tint(.black)
                .hAlign(.trailing)
                .padding(.vertical, 7)
            
            Button {
                isLoading = true
                Task {
                    await signInVM.signIn(emailID: emailID, password: password)
                    if !signInVM.authResponse.isSuccessed {
                        toastMessage = signInVM.authResponse.message
                        showToast.toggle()
                    }
                    isLoading = false
                }
            } label: {
                Text("로그인")
                    .foregroundColor(.white)
                    .font(.title3)
                    .bold()
                    .hAlign(.center)
                    .padding(.vertical, 10)
            }
            .buttonStyle(.borderedProminent)
            .tint(.accentColor)
            .disabled(activeButton)
            
            Spacer()
            HStack {
                Text("아직 회원이 아니세요?")
                    .foregroundColor(.gray)
                
                Button {
                    createAccount.toggle()
                } label: {
                    Text("회원가입")
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                }
            }
        }
        .padding(30)
        .overlay {
            LoadingView(showLoading: $isLoading)
        }
        // MARK: 회원가입 뷰 via Sheet
        .fullScreenCover(isPresented: $createAccount) {
            SignUpView()
        }
        .fullScreenCover(isPresented: $resetPassword) {
            ResetPasswordView()
        }
        .showToast(showToast: $showToast, content:
            FabulaToast(showToast: $showToast,
                        toastData: FabulaToast.ToastData(title: "에러!", message: toastMessage, backgroundColor: Color.red),
                        position: .top)
        )
    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
