//
//  CSVExport.swift
//  patreon-subs
//
//  Created by Joseph Mattiello on 8/13/24.
//

import Foundation

import Foundation

func createPaidSubscriberCSV(subscribers: [Subscriber], outputPath: String) {
    var csvContent = "First name,Last name,Email\n"
    
    let paidSubscribers = subscribers.filter { $0.lastChargeStatus == "Paid" }
    
    for subscriber in paidSubscribers {
        let nameParts = subscriber.name.components(separatedBy: " ")
        let firstName = nameParts.first ?? ""
        let lastName = nameParts.count > 1 ? nameParts.dropFirst().joined(separator: " ") : ""
        
        let csvLine = "\"\(firstName)\",\"\(lastName)\",\"\(subscriber.email)\"\n"
        csvContent += csvLine
    }
    
    do {
        try csvContent.write(toFile: outputPath, atomically: true, encoding: .utf8)
        print("Paid subscribers CSV created successfully at: \(outputPath)")
    } catch {
        print("Error writing CSV file: \(error.localizedDescription)")
    }
}
