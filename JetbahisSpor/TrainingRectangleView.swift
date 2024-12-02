//
//  TrainingRectangleView.swift
//  JetbahisSpor
//
//  Created by Nicolae Chivriga on 02/12/2024.
//

import SwiftUI


struct TrainingRectangleView: View {
    @EnvironmentObject private var rootManager: RootNavigation
    let trainingModel: TrainingModel
    var body: some View {
        RoundedRectangle(cornerRadius: 40)
            .overlay {
                VStack {
                    HStack {
                       Image("analytics")
                            .resizable()
                            .frame(width: 29, height: 24)
                            .opacity(0)
                            .foregroundStyle(.white)
                        
                        Spacer()
                        
                        Text(trainingModel.date)
                            .foregroundStyle(Color.init(hex: "#626060"))
                            .font(.custom(Font.inter, size: 25))
                        
                        Spacer()
                        
                        Image("analytics")
                             .resizable()
                             .frame(width: 29, height: 24)
                             .foregroundStyle(.white)
                    }
                    Spacer()
                    
                    VStack {
                        HStack {
                            Text(trainingModel.training ? ( rootManager.turkish ? "Eğitim aralığı" : "Training interval") : (rootManager.turkish ? "Hedefler" : "Goals"))
                                .font(.custom(Font.inter, size: 15))
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.init(hex: "#D9D9D9"))
                                .overlay(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.init(hex: "#853836"))
                                        .frame(width: 110 * (Double(trainingModel.trainingInterval)) / (trainingModel.training ? 180 : 51) , height: 4)
                                        .padding(.horizontal, 10)
                                }
                                .frame(width: 127, height: 11)
                        }
                        .padding(.horizontal)
                        
                        HStack() {
                            Text(trainingModel.training ? ( rootManager.turkish ? "Kafa sayısı" : "Number of heads") : (rootManager.turkish ? "Gol atma girişimleri" : "Attempts to score a goal"))
                                .font(.custom(Font.inter, size: 15))
                                .foregroundStyle(.white)
                            
                            Spacer()
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.init(hex: "#D9D9D9"))
                                .overlay(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.init(hex: "#418536"))
                                        .frame(width: 110 * (Double(trainingModel.numberHeads)) / (trainingModel.training ? 60 : 60) , height: 4)
                                        .padding(.horizontal, 10)
                                }
                                .frame(width: 127, height: 11)
                        }
                        .padding(.horizontal)
                        
                        HStack() {
                            Text(rootManager.turkish ? "Çalışma süresi" : "Running time")
                                .font(.custom(Font.inter, size: 15))
                                .foregroundStyle(.white)
                            
                            Spacer()
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.init(hex: "#D9D9D9"))
                                .overlay(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.init(hex: "#853836"))
                                        .frame(width: 110 * (Double(trainingModel.runningTime) / 180), height: 4)
                                        .padding(.horizontal, 10)
                                        .onAppear() {
                                            let width = 110 * (Double(trainingModel.runningTime) / 180)
                                            print(width) // Should print 55.0 for this example
                                        }
                                }
                                .frame(width: 127, height: 11)
                        }
                        .padding(.horizontal)
                    }
                  
                }
                .padding()
            }
            .padding(.horizontal)
            .frame(height: 190)
    }
}
