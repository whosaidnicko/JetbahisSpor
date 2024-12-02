//
//  LandingView.swift
//  JetbahisSpor
//
//  Created by Nicolae Chivriga on 30/11/2024.
//

import SwiftUI

struct LandingView: View {
    @EnvironmentObject private var rootNavigation: RootNavigation
    @State var languageChoosed: Bool = false
    @State var presentedSlide: Int = 0
    var body: some View {
        
        ZStack {
            Group {
                if languageChoosed {
                    TabView(selection: $presentedSlide) {
                        ZStack {
                            Image(rootNavigation.turkish ? "firstTr" : "firstEn")
                                .resizable()
                                .ignoresSafeArea()
                            
                            VStack {
                                Spacer()
                                
                                Button {
                                    withAnimation {
                                        presentedSlide += 1
                                    }
                                } label: {
                                    RoundedRectangle(cornerRadius: 40)
                                        .fill(Color.init(hex: "#141414"))
                                        .frame(width: 280, height: 40)
                                        .overlay {
                                            Text("Next")
                                                .foregroundStyle(.white)
                                                .font(.custom(Font.inter, size: 25))
                                        }
                                    
                                }
                                
                            }
                            .padding()
                        }
                        .tag(0)
                        
                        
                        ZStack {
                            Image(rootNavigation.turkish ? "secondTr" : "secondEn")
                                .resizable()
                                .ignoresSafeArea()
                            
                            VStack {
                                Spacer()
                                
                                Button {
                                    withAnimation {
                                        presentedSlide += 1
                                    }
                                } label: {
                                    RoundedRectangle(cornerRadius: 40)
                                        .fill(Color.init(hex: "#141414"))
                                        .frame(width: 280, height: 40)
                                        .overlay {
                                            Text("Next")
                                                .foregroundStyle(.white)
                                                .font(.custom(Font.inter, size: 25))
                                        }
                                    
                                }
                                
                            }
                            .padding()
                        }
                        .tag(1)
                        
                        ZStack {
                            Image(rootNavigation.turkish ? "lastTr" : "lastEn")
                                .resizable()
                                .ignoresSafeArea()
                            
                            VStack {
                                Spacer()
                                
                                Button {
                                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                                    impactMed.impactOccurred()
                                    rootNavigation.landing = false 
                                    rootNavigation.navigationChoice = .loading
                                } label: {
                                    RoundedRectangle(cornerRadius: 40)
                                        .fill(Color.init(hex: "#141414"))
                                        .frame(width: 280, height: 40)
                                        .overlay {
                                            Text("Start")
                                                .foregroundStyle(.white)
                                                .font(.custom(Font.inter, size: 25))
                                        }
                                    
                                }
                                
                            }
                            .padding()
                        }
                        .tag(2)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                } else {
                    HStack(spacing: 45) {
                        
                        Image("turkeyFlag")
                            .onTapGesture {
                                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                                impactMed.impactOccurred()
                                rootNavigation.turkish = true
                                languageChoosed = true
                            }
                        
                        Image("englandFlag")
                            .onTapGesture {
                                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                                impactMed.impactOccurred()
                                rootNavigation.turkish = false
                                languageChoosed = true
                            }
                    }
                }
            }
            .transition(.scale)
        }
       
        .ignoresSafeArea()
        
    }
}
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
struct RoundedCorner: Shape {
    let radius: CGFloat
    let corners: UIRectCorner

    init(radius: CGFloat = .infinity, corners: UIRectCorner = .allCorners) {
        self.radius = radius
        self.corners = corners
    }

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
