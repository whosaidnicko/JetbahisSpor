//
//  SettingsView.swift
//  JetbahisSpor
//
//  Created by Nicolae Chivriga on 02/12/2024.
//

import SwiftUI
import StoreKit


struct SettingsView: View {
    @Environment(\.requestReview) var requestReview
    @EnvironmentObject private var navigationChoice: RootNavigation
    var body: some View {
        ZStack {
            Color.init(hex: "#1B1A1A")
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        navigationChoice.showSettings = false
                    } label: {
                        Image("close")
                    }

                  
                }
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
               
                
                buttonLabel(text: navigationChoice.turkish ? "Bizi değerlendirin" : "Rate us") {
                    requestReview()
                }
                
                buttonLabel(text: navigationChoice.turkish ? "Bize ulaşın" : "Contact us") {
                    if let url = URL(string: "mailto:roccolplenton1724@gmail.com") {
                        if UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url)
                        }
                    }
                }

                
                HStack(spacing: 40) {
                    Image("turkeyFlag")
                        .scaleEffect(navigationChoice.turkish ? 1: 0.8)
                        .onTapGesture {
                            navigationChoice.turkish = true
                        }
                    
                    
                    Image("englandFlag")
                        .scaleEffect(!navigationChoice.turkish ? 1: 0.8)
                        .onTapGesture {
                            navigationChoice.turkish = !true
                        }
                }
                .animation(Animation.bouncy, value: navigationChoice.turkish)
                .padding(.horizontal)
                .padding(.top, 30)

                Spacer()
            }
            .padding()
            
        }
    }
    
    func buttonLabel(text: String, action: @escaping() -> Void) -> some View {
        Button {
            action()
        } label: {
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.init(hex: "#141414"))
                .overlay {
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.init(hex: "#363636")
                            ,lineWidth: 1)
                    Text(text)
                        .font(.custom(Font.inter, size: 25))
                        .foregroundStyle(.white)
                }
                .frame(width: 350, height: 50)
        }

        
    }
}
