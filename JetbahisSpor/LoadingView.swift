//
//  LoadingView.swift
//  JetbahisSpor
//
//  Created by Nicolae Chivriga on 30/11/2024.
//

import SwiftUI


struct LoadingView: View {
    @EnvironmentObject private var navigationRoot: RootNavigation
    @State var loadingStart: Bool = false
    var body: some View {
        VStack {
            Image("logo")
            
            RoundedRectangle(cornerRadius: 100)
                .stroke(Color.init(hex: "#FE2C26")
                    ,lineWidth: 1)
                .overlay(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 100)
                        .fill(.white)
                        .frame(width: 264 * (loadingStart ? 1 : 0), height: 8)
                        .padding(.horizontal, 5)
                }
                .frame(width: 278, height: 17)
            
            Spacer()
                .onAppear() {
                    withAnimation(Animation.linear(duration: 2)) {
                        loadingStart = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        if navigationRoot.landing {
                            navigationRoot.navigationChoice = .landing
                        } else {
                            navigationRoot.navigationChoice = .football
                        }
                    }
                }
        }
    }
}
