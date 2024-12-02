//
//  TrainingView.swift
//  JetbahisSpor
//
//  Created by Nicolae Chivriga on 01/12/2024.
//

import SwiftUI


struct TrainingView: View {
    @EnvironmentObject private var rootManager: RootNavigation
    @State var training: Bool = true
    @State var trainingSelected: Bool?
    @State private var selectedDate = Date()
    @State var numberOfHeads: Int = 0
    @State var trainingTimer: Double = 0
    @State var runningTime: Double = 0
    @State var showList: Bool = false
//    @State var numberOfHeads: Int = 0
    var formattedDate: String {
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "dd MMM yyyy" // Format as "11 Dec 2024"
          return dateFormatter.string(from: selectedDate)
      }
    init() {
        let thumbImage = UIImage(named: "thumbe")
                UISlider.appearance().setThumbImage(thumbImage, for: .normal)
            
    }
    var body: some View {
        VStack {
            Group {
                HStack {
                    Text(trainingSelected == nil ? ( rootManager.turkish ? "Günlük" : "Diary") : (trainingSelected! ? (rootManager.turkish ? "Eğitim" : "Training") : rootManager.turkish ? "Maç" : "Match"))
                        .font(.custom(Font.inter, size: 23))
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    Button {
                        rootManager.showSettings = true
                    } label: {
                        Image("settings")
                            .foregroundStyle(Color.init(hex: "#5B5B5B"))
                    }
                    
                    Button {
                        withAnimation {
                            showList.toggle()
                        }
                        
                    } label: {
                        Image("calendr")
                            .foregroundStyle(showList ? .white : Color.init(hex: "#5B5B5B"))
                    }
                    
                }
                if !showList {
                    if trainingSelected == nil {
                        DatePicker(
                            "Date",
                            selection: $selectedDate,
                            in: Date()..., // Starts from today's date
                            displayedComponents: [.date]
                        )
                        .foregroundColor(.white)
                        .datePickerStyle(.compact)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .accentColor(.green)
                        .colorScheme(.dark) // or .light to get black text
                        .padding()
                        
                        buttonTrain(text: rootManager.turkish ? "Eğitim" : "Training") {
                            training = true
                        }
                        .opacity(training ? 1 : 0.5)
                        .padding(.top, 50)
                        
                        buttonTrain(text: rootManager.turkish ? "Maç" : "Match") {
                            training = false
                        }
                        .opacity(!training ? 1 : 0.5)
                        
                        Spacer()
                        Button {
                            withAnimation {
                                trainingSelected = training
                            }
                        } label: {
                            RoundedRectangle(cornerRadius: 40)
                                .fill(Color.init(hex: "#141414"))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 40)
                                        .stroke(Color.init(hex: "#252525")
                                                ,lineWidth: 1)
                                    
                                    Image("checkMark")
                                    
                                    
                                }
                                .frame(height: 67)
                        }
                    } else {
                        if trainingSelected! {
                            ScrollView {
                                Text(formattedDate)
                                    .font(.custom(Font.inter, size: 25))
                                    .foregroundStyle(Color.init(hex: "#626060"))
                                
                                
                                RoundedRectangle(cornerRadius: 40)
                                    .fill(Color.init(hex: "#141414"))
                                    .overlay {
                                        VStack() {
                                            Text(rootManager.turkish ? "Eğitim aralığı" : "Training interval")
                                                .font(.custom(Font.inter, size: 25))
                                                .foregroundStyle(.white)
                                            
                                            Spacer()
                                            
                                            Slider(value: $trainingTimer, in: 1...180, step: 1)
                                                .frame(width: 260, height: 11)
                                                .accentColor(.red)
                                            
                                            Spacer()
                                            
                                            Text("\(String(Int(trainingTimer))) min")
                                                .foregroundStyle(Color.init(hex: "#626060"))
                                                .font(.custom(Font.inter, size: 25))
                                        }
                                        .padding(.vertical)
                                    }
                                    .frame(height: 178)
                                
                                RoundedRectangle(cornerRadius: 40)
                                    .fill(Color.init(hex: "#141414"))
                                    .overlay {
                                        VStack(spacing: 40) {
                                            Text(rootManager.turkish ? "Kafa sayısı" : "Number of heads")
                                                .font(.custom(Font.inter, size: 25))
                                                .foregroundStyle(.white)
                                            
                                            Spacer()
                                            
                                            HStack(spacing: 10) {
                                                Button {
                                                    if numberOfHeads > 0 {
                                                        numberOfHeads -= 1
                                                    }
                                                } label: {
                                                    RoundedRectangle(cornerRadius: 40)
                                                        .fill(Color.init(hex: "#141414"))
                                                        .overlay {
                                                            RoundedRectangle(cornerRadius: 40)
                                                                .stroke(Color.init(hex: "#363636")
                                                                        ,lineWidth: 1)
                                                            Text("-")
                                                                .foregroundStyle(.white)
                                                                .font(.custom(Font.inter, size: 25))
                                                        }
                                                        .frame(width: 43, height: 41)
                                                }
                                                
                                                
                                                RoundedRectangle(cornerRadius: 40)
                                                    .fill(Color.init(hex: "#141414"))
                                                    .overlay {
                                                        RoundedRectangle(cornerRadius: 40)
                                                            .stroke(Color.init(hex: "#363636")
                                                                    ,lineWidth: 1)
                                                        Text(String(numberOfHeads))
                                                            .foregroundStyle(.white)
                                                            .font(.custom(Font.inter, size: 25))
                                                    }
                                                    .frame(width: 85, height: 41)
                                                
                                                Button {
                                                    if numberOfHeads < 61 {
                                                        numberOfHeads += 1
                                                    }
                                                    
                                                } label: {
                                                    RoundedRectangle(cornerRadius: 40)
                                                        .fill(Color.init(hex: "#141414"))
                                                        .overlay {
                                                            RoundedRectangle(cornerRadius: 40)
                                                                .stroke(Color.init(hex: "#363636")
                                                                        ,lineWidth: 1)
                                                            Text("+")
                                                                .foregroundStyle(.white)
                                                                .font(.custom(Font.inter, size: 25))
                                                        }
                                                        .frame(width: 43, height: 41)
                                                }
                                            }
                                        }
                                        .padding(.vertical)
                                    }
                                    .frame(height: 178)
                                
                                RoundedRectangle(cornerRadius: 40)
                                    .fill(Color.init(hex: "#141414"))
                                    .overlay {
                                        VStack() {
                                            Text(rootManager.turkish ? "Çalışma süresi" : "Running time")
                                                .font(.custom(Font.inter, size: 25))
                                                .foregroundStyle(.white)
                                            
                                            Spacer()
                                            
                                            Slider(value: $runningTime, in: 1...180, step: 1)
                                                .frame(width: 260, height: 11)
                                                .accentColor(.red)
                                            
                                            Spacer()
                                            
                                            Text("\(String(Int(runningTime))) min")
                                                .foregroundStyle(Color.init(hex: "#626060"))
                                                .font(.custom(Font.inter, size: 25))
                                        }
                                        .padding(.vertical)
                                    }
                                    .frame(height: 178)
                                Button {
                                   
                                    saveToUserDefaults(model: TrainingModel(date: formattedDate,training: true, trainingInterval: Int(trainingTimer), numberHeads: numberOfHeads, runningTime: Int(runningTime)), key: "mod")
                                    withAnimation {
                                        numberOfHeads = 0
                                        trainingTimer = 0
                                        runningTime = 0
                                        trainingSelected = nil
                                    }
                                } label: {
                                    RoundedRectangle(cornerRadius: 40)
                                        .fill(Color.init(hex: "#141414"))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 40)
                                                .stroke(Color.init(hex: "#363636")
                                                        ,lineWidth: 1)
                                            
                                            Text(rootManager.turkish ? "Kaydet" : "Save")
                                                .font(.custom(Font.inter, size: 25))
                                                .foregroundStyle(.white)
                                        }
                                        .frame(width: 200, height: 41)
                                }
                                
                            }
                            
                            
                            Spacer()
                        } else {
                            ScrollView {
                                Text(formattedDate)
                                    .font(.custom(Font.inter, size: 25))
                                    .foregroundStyle(Color.init(hex: "#626060"))
                                
                                RoundedRectangle(cornerRadius: 40)
                                    .fill(Color.init(hex: "#141414"))
                                    .overlay {
                                        VStack(spacing: 40) {
                                            Text(rootManager.turkish ? "Hedefler" : "Goals")
                                                .font(.custom(Font.inter, size: 25))
                                                .foregroundStyle(.white)
                                            
                                            Spacer()
                                            
                                            HStack(spacing: 10) {
                                                Button {
                                                    if trainingTimer > 0 {
                                                        trainingTimer -= 1
                                                    }
                                                } label: {
                                                    RoundedRectangle(cornerRadius: 40)
                                                        .fill(Color.init(hex: "#141414"))
                                                        .overlay {
                                                            RoundedRectangle(cornerRadius: 40)
                                                                .stroke(Color.init(hex: "#363636")
                                                                        ,lineWidth: 1)
                                                            Text("-")
                                                                .foregroundStyle(.white)
                                                                .font(.custom(Font.inter, size: 25))
                                                        }
                                                        .frame(width: 43, height: 41)
                                                }
                                                
                                                
                                                RoundedRectangle(cornerRadius: 40)
                                                    .fill(Color.init(hex: "#141414"))
                                                    .overlay {
                                                        RoundedRectangle(cornerRadius: 40)
                                                            .stroke(Color.init(hex: "#363636")
                                                                    ,lineWidth: 1)
                                                        Text(String(trainingTimer))
                                                            .foregroundStyle(.white)
                                                            .font(.custom(Font.inter, size: 25))
                                                    }
                                                    .frame(width: 85, height: 41)
                                                
                                                Button {
                                                    if trainingTimer < 51 {
                                                        trainingTimer += 1
                                                    }
                                                    
                                                } label: {
                                                    RoundedRectangle(cornerRadius: 40)
                                                        .fill(Color.init(hex: "#141414"))
                                                        .overlay {
                                                            RoundedRectangle(cornerRadius: 40)
                                                                .stroke(Color.init(hex: "#363636")
                                                                        ,lineWidth: 1)
                                                            Text("+")
                                                                .foregroundStyle(.white)
                                                                .font(.custom(Font.inter, size: 25))
                                                        }
                                                        .frame(width: 43, height: 41)
                                                }
                                            }
                                        }
                                        .padding(.vertical)
                                    }
                                    .frame(height: 178)
                                
                                
                                
                                RoundedRectangle(cornerRadius: 40)
                                    .fill(Color.init(hex: "#141414"))
                                    .overlay {
                                        VStack(spacing: 40) {
                                            Text(rootManager.turkish ? "Gol atma girişimleri" : "Attempts to score a goal")
                                                .font(.custom(Font.inter, size: 25))
                                                .foregroundStyle(.white)
                                            
                                            Spacer()
                                            
                                            HStack(spacing: 10) {
                                                Button {
                                                    if numberOfHeads > 0 {
                                                        numberOfHeads -= 1
                                                    }
                                                } label: {
                                                    RoundedRectangle(cornerRadius: 40)
                                                        .fill(Color.init(hex: "#141414"))
                                                        .overlay {
                                                            RoundedRectangle(cornerRadius: 40)
                                                                .stroke(Color.init(hex: "#363636")
                                                                        ,lineWidth: 1)
                                                            Text("-")
                                                                .foregroundStyle(.white)
                                                                .font(.custom(Font.inter, size: 25))
                                                        }
                                                        .frame(width: 43, height: 41)
                                                }
                                                
                                                
                                                RoundedRectangle(cornerRadius: 40)
                                                    .fill(Color.init(hex: "#141414"))
                                                    .overlay {
                                                        RoundedRectangle(cornerRadius: 40)
                                                            .stroke(Color.init(hex: "#363636")
                                                                    ,lineWidth: 1)
                                                        Text(String(numberOfHeads))
                                                            .foregroundStyle(.white)
                                                            .font(.custom(Font.inter, size: 25))
                                                    }
                                                    .frame(width: 85, height: 41)
                                                
                                                Button {
                                                    if numberOfHeads < 61 {
                                                        numberOfHeads += 1
                                                    }
                                                    
                                                } label: {
                                                    RoundedRectangle(cornerRadius: 40)
                                                        .fill(Color.init(hex: "#141414"))
                                                        .overlay {
                                                            RoundedRectangle(cornerRadius: 40)
                                                                .stroke(Color.init(hex: "#363636")
                                                                        ,lineWidth: 1)
                                                            Text("+")
                                                                .foregroundStyle(.white)
                                                                .font(.custom(Font.inter, size: 25))
                                                        }
                                                        .frame(width: 43, height: 41)
                                                }
                                            }
                                        }
                                        .padding(.vertical)
                                    }
                                    .frame(height: 178)
                                
                                
                                RoundedRectangle(cornerRadius: 40)
                                    .fill(Color.init(hex: "#141414"))
                                    .overlay {
                                        VStack() {
                                            Text(rootManager.turkish ? "Çalışma süresi" : "Running time")
                                                .font(.custom(Font.inter, size: 25))
                                                .foregroundStyle(.white)
                                            
                                            Spacer()
                                            
                                            Slider(value: $runningTime, in: 1...180, step: 1)
                                                .frame(width: 260, height: 11)
                                                .accentColor(.red)
                                            
                                            Spacer()
                                            
                                            Text("\(String(Int(runningTime))) min")
                                                .foregroundStyle(Color.init(hex: "#626060"))
                                                .font(.custom(Font.inter, size: 25))
                                        }
                                        .padding(.vertical)
                                    }
                                    .frame(height: 178)
                                
                                Button {
                                  
                                    saveToUserDefaults(model: TrainingModel(date: formattedDate,training: false, trainingInterval: Int(trainingTimer), numberHeads: numberOfHeads, runningTime: Int(runningTime)), key: "mod")
                                    withAnimation {
                                        numberOfHeads = 0
                                        trainingTimer = 0
                                        runningTime = 0
                                        trainingSelected = nil
                                    }
                                } label: {
                                    RoundedRectangle(cornerRadius: 40)
                                        .fill(Color.init(hex: "#141414"))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 40)
                                                .stroke(Color.init(hex: "#363636")
                                                        ,lineWidth: 1)
                                            
                                            Text(rootManager.turkish ? "Kaydet" : "Save")
                                                .font(.custom(Font.inter, size: 25))
                                                .foregroundStyle(.white)
                                        }
                                        .frame(width: 200, height: 41)
                                }
                            }
                            Spacer()
                        }
                    }
                } else {
                    ScrollView {
                        if let array = retrieveArrayFromUserDefaults(key: "mod") {
                            ForEach(array.indices, id: \.self) { mod in
                                
                                TrainingRectangleView(trainingModel: array[mod])
                            }
                        }
                    }
                }
            }
            .transition(.scale)
            
            
        }
        .padding()
        
    }
    
    func buttonTrain(text: String
        ,action: @escaping() -> Void) -> some View {
        Button {
            action()
        } label: {
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.init(hex: "#141414"))
                .overlay {
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.init(hex: "#252525")
                            ,lineWidth: 1)
                    
                    Text(text)
                        .font(.custom(Font.inter, size: 25))
                        .foregroundStyle(.white)
                }
                .frame(height: 67)
        }
    }
    
}
struct TrainingModel: Codable {
    let id = UUID()
    var date: String
    var training: Bool
    var trainingInterval: Int
    var numberHeads: Int
    var runningTime: Int
}
func saveToUserDefaults(model: TrainingModel, key: String) {
    // Retrieve existing data from UserDefaults
    var currentModels: [TrainingModel] = retrieveArrayFromUserDefaults(key: key) ?? []
    
    // Append the new model to the array
    currentModels.append(model)
    
    // Save the updated array back to UserDefaults
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(currentModels) {
        UserDefaults.standard.set(encoded, forKey: key)
    }
}
func retrieveArrayFromUserDefaults(key: String) -> [TrainingModel]? {
    if let savedData = UserDefaults.standard.data(forKey: key) {
        let decoder = JSONDecoder()
        if let loadedModels = try? decoder.decode([TrainingModel].self, from: savedData) {
            return loadedModels
        }
    }
    return nil
}
