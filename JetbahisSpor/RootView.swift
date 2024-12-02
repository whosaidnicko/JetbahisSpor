//
//  RootView.swift
//  JetbahisSpor
//
//  Created by Nicolae Chivriga on 30/11/2024.
//

import SwiftUI


struct RootView: View {
    @StateObject private var rootNavigation: RootNavigation = RootNavigation.shared
    var body: some View {
        ZStack {
            if rootNavigation.navigationChoice == .loading {
                Image("loadingBackground")
                    .resizable()
                    .ignoresSafeArea()
            } else {
                Color.init(hex: "#1B1A1A")
                    .ignoresSafeArea()
            }
            
            VStack(spacing: 0) {
                Group {
                    switch rootNavigation.navigationChoice {
                    case .loading:
                        LoadingView()
                    case .football:
                        FootballMatchesView()
                    case .landing:
                        LandingView()
                    case .training:
                        TrainingView()
                    case .stats:
                        StatsView()
                    }
                }
                .transition(.scale)
                
              
                
                if rootNavigation.navigationChoice != .landing && rootNavigation.navigationChoice != .loading {
                    Spacer()
                    tabView()
                        
                }
            }
            .animation(Animation.default, value: rootNavigation.navigationChoice)
            .edgesIgnoringSafeArea(.bottom)
            
        }
       
        .sheet(isPresented: $rootNavigation.showSettings) {
            SettingsView()
        }
        .environmentObject(rootNavigation)
    }
    
    func tabView() -> some View {
        Rectangle()
            .fill(Color.init(hex: "#141414"))
            .cornerRadius(98, corners: [.topLeft, .topRight])
            .overlay {
                HStack {
                    Image("training")
                        .foregroundStyle(rootNavigation.navigationChoice == .training ? Color.white : Color.init(hex: "#853836"))
                        .scaleEffect(rootNavigation.navigationChoice == .training ? 1 : 0.8)
                        .onTapGesture {
                            let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                            impactHeavy.impactOccurred()
                            rootNavigation.navigationChoice = .training
                        }
                    Spacer()
                    
                    Image("matchHistoryImg")
                        .foregroundStyle(rootNavigation.navigationChoice == .football ? Color.white : Color.init(hex: "#853836"))
                        .scaleEffect(rootNavigation.navigationChoice == .football ? 1 : 0.8)
                        .onTapGesture {
                            let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                            impactHeavy.impactOccurred()
                            rootNavigation.navigationChoice = .football
                        }
                    
                    Spacer()
                    
                    Image("analytics")
                        .foregroundStyle(rootNavigation.navigationChoice == .stats ? Color.white : Color.init(hex: "#853836"))
                        .scaleEffect(rootNavigation.navigationChoice == .stats ? 1 : 0.8)
                        .onTapGesture {
                            let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                            impactHeavy.impactOccurred()
                            rootNavigation.navigationChoice = .stats
                        }
                }
                .padding(.horizontal, 45)
                .animation(Animation.default, value: rootNavigation.navigationChoice)
            }
            .frame(height: 90)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}


extension Font {
    static var inter: String = "Inter28pt-Bold"
}
