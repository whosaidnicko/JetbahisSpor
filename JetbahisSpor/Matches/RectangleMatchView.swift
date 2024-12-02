//
//  RectangleMatchView.swift
//  JetbahisSpor
//
//  Created by Nicolae Chivriga on 01/12/2024.
//

import Kingfisher
import SwiftUI


struct RectangleMatchView: View {
    let time: Double
    let match: Match
    @State var appear: Bool = false
    var body: some View {
        RoundedRectangle(cornerRadius: 40)
            .fill(Color.init(hex: "#141414"))
            .overlay {
                RoundedRectangle(cornerRadius: 40)
                    .stroke(Color.init(hex: "#363636")
                        ,lineWidth: 1)
                
                VStack {
                    HStack {
                        HStack(spacing: 4) {
                            KFImage(URL(string: match.homeTeam.crest ?? ""))
                                .placeholder {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle())
                                        .frame(width: 100, height: 70)
                                }
                                .retry(maxCount: 3, interval: .seconds(3))
                                .onFailure { error in
                                    print("Failed to load image: \(error.localizedDescription)")
                                }
                                .resizable()
                                .scaledToFit()
                            
                            Text(String(match.score.fullTime.home ?? 0))
                                .font(.custom(Font.inter, size: 30))
                                .foregroundStyle(.white)
                        }
                        
                        Spacer()
                        
                        Text(":")
                            .font(.custom(Font.inter, size: 30))
                            .foregroundStyle(.white)
                        
                        Spacer()
                        
                        HStack(spacing: 4) {
                            Text(String(match.score.fullTime.away ?? 0))
                                .font(.custom(Font.inter, size: 30))
                                .foregroundStyle(.white)
                            
                            KFImage(URL(string: match.awayTeam.crest ?? ""))
                                .placeholder {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle())
                                        .frame(width: 100, height: 70)
                                }
                                .retry(maxCount: 3, interval: .seconds(3))
                                .onFailure { error in
                                    print("Failed to load image: \(error.localizedDescription)")
                                }
                                .resizable()
                                .scaledToFit()
                        }
                    }
                  
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.init(hex: "#272727"))
                        .overlay {
                            HStack {
                                Text(match.homeTeam.shortName)
                                    .font(.custom(Font.inter, size: 15))
                                    .foregroundStyle(.white)
                                
                                Spacer()
                                
                                Text(match.awayTeam.shortName)
                                    .font(.custom(Font.inter, size: 15))
                                    .foregroundStyle(.white)
                            }
                            .padding(.horizontal)
                        }
                        .frame(height: 27)
                }
                .padding(.horizontal)
            }
            .frame(height: 186)
            .offset(x: appear ? 0 :(Bool.random() ? -UIScreen.main.bounds.width : UIScreen.main.bounds.width))
            .animation(Animation.bouncy, value: appear)
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                    appear = true
                }
            }
            .padding(.horizontal)
    }
}
