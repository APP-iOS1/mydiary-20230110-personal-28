//
//  MainView.swift
//  MyBullet
//
//  Created by Roen White on 2023/01/11.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "checkmark.circle.fill")
                    Text("할일목록")
                }
                .preferredColorScheme(.light)
            
            Text("내 정보")
                .tabItem {
                    Image(systemName: "gear")
                    Text("내 정보")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
