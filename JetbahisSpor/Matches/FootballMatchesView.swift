//
//  FootballMatchesView.swift
//  JetbahisSpor
//
//  Created by Nicolae Chivriga on 01/12/2024.
//

import SwiftUI


struct FootballMatchesView: View {
    @EnvironmentObject private var rootNavigaton: RootNavigation
    @State var showFinishedMatches: Bool = false
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                HStack {
                    Text(showFinishedMatches ? (rootNavigaton.turkish ? "Tarih" : "History") : (rootNavigaton.turkish ? "Canlı maçlar" : "Live matches"))
                        .font(.custom(Font.inter, size: 20))
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    HStack(spacing: 8) {
                        Button {
                            rootNavigaton.showSettings = true
                        } label: {
                            Image("settings")
                                .foregroundStyle(Color.init(hex: "#5B5B5B"))
                        }
                        
                    }
                    
                }
                
                
                
                
                
                if rootNavigaton.answearReceived {
                    if rootNavigaton.matches.isEmpty {
                        VStack(spacing: 50) {
                            Text(rootNavigaton.turkish ? "Canlı maç yok" : "There are no live matches")
                                .font(.custom(Font.inter, size: 40))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 30)
                                .foregroundStyle(.white)
                                .padding(.top, 120)
                            
                            Button {
                                rootNavigaton.answearReceived = false
                                rootNavigaton.todayMatches = true
                                rootNavigaton.fetchLiveMatches()
                            } label: {
                                RoundedRectangle(cornerRadius: 40)
                                    .fill(Color.init(hex: "#141414"))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 40)
                                            .stroke(Color.init(hex: "#363636")
                                                    ,lineWidth: 1)
                                        Text(rootNavigaton.turkish ? "Bugünün maçlarına bakın" : "See today's matches")
                                            .font(.custom(Font.inter, size: 25))
                                            .foregroundStyle(.white)
                                    }
                                    .frame(width: 350, height: 50)
                            }
                        }
                    } else {
                        ScrollView {
                            ForEach(Array(rootNavigaton.matches.enumerated()), id: \.1.id) { index, match in
                                RectangleMatchView(time: Double(index) / 5, match: match)
                            }
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
            .onAppear()  {
                
            }
            
            if !rootNavigaton.answearReceived {
                ProgressView()
                    .tint(.white)
                    .scaleEffect(2)
            }
        }
    }
}

