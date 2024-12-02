//
//  RootNavigation.swift
//  JetbahisSpor
//
//  Created by Nicolae Chivriga on 30/11/2024.
//

import SwiftUI
import Combine


final class RootNavigation: ObservableObject {
    static var shared: RootNavigation = RootNavigation()
    @AppStorage("language") var turkish: Bool = true
    @AppStorage("landing") var landing: Bool = true
    @Published var navigationChoice: NavigationChoice = .loading
    @Published var showSettings: Bool = false
    @Published var answearReceived: Bool = false
    @Published var todayMatches: Bool = false
    @Published var matches: [Match] = []
    @Published var stats: [StatsModel] = []
    private var cancellable: AnyCancellable?
    init() {
        fetchLiveMatches()
    }
    private let apiKey = "136216cc622f4df8b11b266e2059148b" // Replace with your Football-Data API Key
    
    private let url =  "https://api.football-data.org/v4/matches?status=LIVE"
    
    
    func fetchLiveMatches() {
        
        guard let url = URL(string: todayMatches ? "https://api.football-data.org/v4/matches" : url) else { return }
        
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-Auth-Token")
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let liveMatches = try decoder.decode(LiveMatchResponse.self, from: data)
                    DispatchQueue.main.async {
                        self?.matches = liveMatches.matches
                        self?.answearReceived = true
                        print(liveMatches.matches)
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }.resume()
    }
    
}

// Model for live match data
struct LiveMatch: Identifiable, Codable {
    var id: Int
    var homeTeam: String
    var awayTeam: String
    var score: String
}



struct LiveMatchResponse: Codable {
    let matches: [Match]
}

struct Match: Codable, Identifiable {
    let id: Int
    let homeTeam: Team
    let awayTeam: Team
  
    let score: Score
    var minute: Int?
    let utcDate: String
    
    var formattedTime: String {
        // Convert UTC date to readable format (optional)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = formatter.date(from: utcDate) {
            formatter.dateStyle = .short
            formatter.timeStyle = .short
            return formatter.string(from: date)
        }
        return utcDate
    }
}

struct Team: Codable {
    let id: Int
    let name: String
    let shortName: String
    let crest: String?
}

struct Score: Codable {
    let fullTime: FullTimeScore
    let halfTime: HalfTime
}

struct HalfTime: Codable {
    let home: Int?
    let away: Int?
}
struct FullTimeScore: Codable {
    let home: Int?
    let away: Int?
}
