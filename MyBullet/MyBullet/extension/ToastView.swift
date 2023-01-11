//
//  Toast.swift
//  MyBullet
//
//  Created by Roen White on 2023/01/11.
//

import Foundation
import SwiftUI

struct ToastView: View {
    
    let toastData: FabulaToast.ToastData
    
    var body: some View {
        HStack {
            Image(systemName: "checkmark")
            VStack(alignment: .leading, spacing: 2) {
                Text(LocalizedStringKey(toastData.title))
                    .font(.subheadline)
                    .fontWeight(.bold)
                Text(LocalizedStringKey(toastData.message))
                    .font(.callout)
                    .opacity(0.9)
            }
            Spacer()
        }
        .foregroundColor(Color.white)
        .padding(10)
    }
}

struct FabulaToast: View {
    enum ToastPosition {
        case top
        case bottom
    }
    
    struct ToastData {
        var title: String
        var message: String
        var backgroundColor: Color
    }
    
    @Binding var showToast: Bool
    let toastData: ToastData
    var position: ToastPosition
    
    var body: some View {
        VStack {
            if position == .bottom {
                Spacer()
            }
            if #available(macOS 12.0, *) {
                ToastView(toastData: toastData)
                    .background(toastData.backgroundColor.opacity(0.6))
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
            } else {
                ToastView(toastData: toastData)
                    .background(toastData.backgroundColor.opacity(0.6))
                    .cornerRadius(10)
            }
            
            if position == .top {
                Spacer()
            }
        }
        .padding()
        .opacity(self.showToast ? 1.0 : 0)
        .transition(.move(edge: position == .top ? .top : .bottom))
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                withAnimation {
                    self.showToast = false
                }
            }
        }
        .onTapGesture {
            withAnimation {
                self.showToast = false
            }
        }
    }
}

struct ToastModifier<T: View>: ViewModifier {
    
    @Binding var showToast: Bool
    let content: T
    
    func body(content: Content) -> some View {
        ZStack {
            content
            ZStack {
                if showToast {
                    self.content
                }else {
                    EmptyView()
                }
            }
        }
    }
}

extension View {
    func showToast<T: View>(showToast: Binding<Bool>, content: T) -> some View {
        self.modifier(ToastModifier(showToast: showToast, content: content))
    }
}

