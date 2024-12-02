//
//  StatsView.swift
//  JetbahisSpor
//
//  Created by Nicolae Chivriga on 01/12/2024.
//

import Foundation
import SwiftUI

struct StatsView: View {
    @EnvironmentObject private var rootManager: RootNavigation
    init() {
       UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = UIColor.clear
      
    }
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text(rootManager.turkish ? "İstatistikler" : "Stats")
                        .font(.custom(Font.inter, size: 23))
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    Button {
                        rootManager.showSettings = true
                    } label: {
                        Image("settings")
                            .foregroundStyle(Color.init(hex: "#5B5B5B"))
                    }
                }
                if let trainingData = retrieveArrayFromUserDefaults(key: "mod") {
                    List(trainingData, id: \.id) { item in
                        HStack {
                            // Date and Training Status
                            VStack(alignment: .leading) {
                                Text("Date: \(item.date)")
                                    .font(.headline)
                                Text("Training: \(item.training ? "Yes" : "No")")
                                    .font(.subheadline)
                                    .foregroundColor(item.training ? .green : .red)
                            }
                            
                            Spacer()
                            
                            // Progress Indicator for Training Interval
                            VStack {
                                Text("Interval: \(item.trainingInterval)")
                                    .font(.footnote)
                                ProgressView(value: Double(item.trainingInterval), total: 180)
                                    .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                                    .frame(width: 100)
                            }
                            
                            // Running Time with Icon
                            VStack {
                                Image(systemName: "clock")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.gray)
                                Text("\(item.runningTime) mins")
                                    .font(.caption)
                            }
                        }
                        .padding(.vertical, 5)
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    
                } else {
                    Text(rootManager.turkish ? "BOŞ" : "EMPTY")
                        .foregroundStyle(Color.init(hex: "#696969"))
                        .font(.custom(Font.inter, size: 30))
                }
                Spacer()
            }
            .padding()
            
           
        }
    }
}
