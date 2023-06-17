//
//  Mission.swift
//  Moonshot
//
//  Created by Rishav Gupta on 12/06/23.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
    
    var newFormatLaunchDate: String {
        if let launchDate = launchDate {
            let dateFormatter = DateFormatter()
            //        dateFormatter.dateFormat = "y-MM-dd"
            //        let date = dateFormatter.date(from: launchDate)
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let resultString = dateFormatter.string(from: launchDate)
            return resultString
        } else {
            return "N/A"
        }
    }
}
