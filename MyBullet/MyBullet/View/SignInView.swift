//
//  SignIn.swift
//  MyBullet
//
//  Created by Roen White on 2023/01/10.
//

import SwiftUI

struct SignInView: View {
    // MARK: User Details
    @State var emailID: String = ""
    @State var password: String = ""
    
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
                .padding(.trailing, 15)
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
            
            Button("비밀번호를 잊어버리셨나요?", action: {})
                .fontWeight(.medium)
                .tint(.black)
                .hAlign(.trailing)
                .padding(.vertical, 7)
            
            Button {
                
            } label: {
                Text("로그인")
                    .foregroundColor(.white)
                    .font(.title3)
                    .hAlign(.center)
                    .padding(.vertical, 10)
            }
            .buttonStyle(.borderedProminent)
            .tint(.accentColor)
            
            Spacer()
            HStack {
                Text("아직 계정이 없으세요?")
                    .foregroundColor(.gray)
                
                Button {
                    
                } label: {
                    Text("회원가입")
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                }
            }
        }
        .padding(30)
    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
