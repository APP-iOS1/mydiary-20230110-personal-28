//
//  SignUpView.swift
//  MyBullet
//
//  Created by Roen White on 2023/01/10.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var signInVM: SignInViewModel
    var signUpVM: SignUpViewModel = SignUpViewModel()
    
    // MARK: User Details
    @State private var emailID: String = ""
    @State private var displayName: String = ""
    @State private var password: String = ""
    @State private var passwordCheck: String = ""
    @State private var termsAgree: Bool = false
    
    // MARK: View Properties
    @Environment(\.dismiss) var dismiss
    
    private var validEmail: Bool {
        !isValidEmail(emailID)
    }
    private var validDisplayName: Bool {
        2 <= displayName.count && displayName.count <= 8
    }
    private var validPassword: Bool {
        password.count >= 8
    }
    private var validCheck: Bool {
        passwordCheck == password
    }
    private var activeButton: Bool {
        !validEmail && validDisplayName && validPassword && validCheck && termsAgree
    }
    
    var body: some View {
        NavigationStack {
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
            
            VStack(spacing: 30) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("아이디")
                        Spacer()
                        if !emailID.isEmpty && validEmail {
                            Text("\(Image(systemName: "exclamationmark.triangle")) 잘못된 이메일 형식 입니다.")
                                .foregroundColor(.gray)
                                .font(.callout)
                        }
                    }
                    
                    HStack {
                        TextField("이메일 아이디", text: $emailID)
                            .keyboardType(.emailAddress)
                            .textContentType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                        Button {
                            Task {
                                await signUpVM.checkDuplicateEmail(emailID: emailID)
                            }
                        } label: {
                            Text("중복확인")
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(validEmail)
                    }
                    Rectangle()
                      .frame(height: 1)
                      .foregroundColor(.gray)
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("닉네임")
                        Spacer()
                        if !displayName.isEmpty && !validDisplayName {
                            Text("\(Image(systemName: "exclamationmark.triangle")) 닉네임은 2-8글자여야 합니다.")
                                .foregroundColor(.gray)
                                .font(.callout)
                        }
                    }
                    TextField("2-8 글자의 닉네임", text: $displayName)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                    Rectangle()
                      .frame(height: 1)
                      .foregroundColor(.gray)
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("비밀번호")
                        Spacer()
                        if !password.isEmpty && !validPassword {
                            Text("\(Image(systemName: "exclamationmark.triangle")) 8자리 이상이어야 합니다.")
                                .foregroundColor(.gray)
                                .font(.callout)
                        }
                    }
                    SecureField("8자리 이상의 비밀번호", text: $password)
                        .textContentType(.password)
                    Rectangle()
                      .frame(height: 1)
                      .foregroundColor(.gray)
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("비밀번호 확인")
                        Spacer()
                        if !passwordCheck.isEmpty && !validCheck {
                            Text("\(Image(systemName: "exclamationmark.triangle")) 일치하지 않습니다.")
                                .foregroundColor(.gray)
                                .font(.callout)
                        }
                    }
                    SecureField("비밀번호를 한번 더 입력해주세요.", text: $passwordCheck)
                        .textContentType(.password)
                    Rectangle()
                      .frame(height: 1)
                      .foregroundColor(.gray)
                }
            }
            .font(.title3)
            .hAlign(.leading)
            .padding(.top, 15)
            
            HStack {
                Button {
                    termsAgree.toggle()
                } label: {
                    Text("\(Image(systemName: termsAgree ? "checkmark.square" : "square")) 이용 약관 및 개인정보처리방침 동의")
                        .foregroundColor(.black)
                        .padding(.vertical, 10)
                        .hAlign(.leading)
                }
                NavigationLink {
                    TermsOfUseView()
                } label: {
                    Text("약관보기")
                        .foregroundColor(.gray)
                }
            }
            
            Button {
                Task {
                    dismiss()
                    await signInVM.signUpAndSetNickname(emailID: emailID, password: password, nickname: displayName)
                }
            } label: {
                Text("회원가입")
                    .foregroundColor(.white)
                    .font(.title3)
                    .bold()
                    .hAlign(.center)
                    .padding(.vertical, 10)
            }
            .buttonStyle(.borderedProminent)
            .tint(.accentColor)
            .disabled(!activeButton)
            
            Spacer()
            HStack {
                Text("이미 계정이 있으세요?")
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
        .padding(.horizontal, 30)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
