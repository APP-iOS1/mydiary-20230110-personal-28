//
//  LoadingView.swift
//  MyBullet
//
//  Created by Roen White on 2023/01/11.
//

import SwiftUI

struct LoadingView: View {
    
    @Binding var showLoading: Bool
    
    var body: some View {
        ZStack {
            if showLoading {
                Group {
                    Rectangle()
                        .fill(.black.opacity(0.25))
                        .ignoresSafeArea()
                    
                    ProgressView()
                        .padding(15)
                        .background(.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
            }
        }
        .animation(.easeOut(duration: 0.25), value: showLoading)
    }
}
