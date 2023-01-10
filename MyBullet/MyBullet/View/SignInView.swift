//
//  SignIn.swift
//  MyBullet
//
//  Created by Roen White on 2023/01/10.
//

import SwiftUI

struct SignInView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 15) {
                Image(systemName: "highlighter")
                    .font(.largeTitle)
                    .foregroundColor(.accentColor)
                (Text("일상을 기록하다.")
                    .foregroundColor(.gray) +
                Text("\n마이불렛입니다.")
                )
                .font(.title)
                .fontWeight(.semibold)
                .lineSpacing(10)
                .padding(.top, 20)
                .padding(.trailing, 15)
                
                // MARK: Custom Text Field
            }
            .padding(.leading, 60)
            .padding(.vertical, 15)
        }
    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
