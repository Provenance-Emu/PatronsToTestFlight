//
//  CSVImport.swift
//  patreon-subs
//
//  Created by Joseph Mattiello on 8/13/24.
//

import Foundation

func createSubscribersFromCSV(filePath: String) -> [Subscriber] {
    var subscribers: [Subscriber] = []
    
    guard let content = try? String(contentsOfFile: filePath, encoding: .utf8) else {
        print("Failed to read file at path: \(filePath)")
        return []
    }
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    // Custom CSV parsing to handle quoted fields with newlines
    var rows: [[String]] = []
    var currentRow: [String] = []
    var currentField = ""
    var insideQuotes = false
    
    for char in content {
        switch char {
        case "\"":
            insideQuotes.toggle()
        case ",":
            if insideQuotes {
                currentField.append(char)
            } else {
                currentRow.append(currentField)
                currentField = ""
            }
        case "\n", "\r\n":
            if insideQuotes {
                currentField.append(char)
            } else if !currentField.isEmpty || !currentRow.isEmpty {
                currentRow.append(currentField)
                rows.append(currentRow)
                currentRow = []
                currentField = ""
            }
        default:
            currentField.append(char)
        }
    }
    
    // Add the last field and row if they exist
    if !currentField.isEmpty {
        currentRow.append(currentField)
    }
    if !currentRow.isEmpty {
        rows.append(currentRow)
    }
    
    // Skip the header row
    for row in rows.dropFirst() {
        guard row.count >= 27 else { continue } // Ensure we have all expected columns
        
        let subscriber = Subscriber(
            name: row[0],
            email: row[1],
            discord: row[2].isEmpty ? nil : row[2],
            patronStatus: row[3].isEmpty ? nil : row[3],
            followsYou: row[4] == "Yes",
            freeMember: row[5] == "Yes",
            freeTrial: row[6] == "Yes",
            lifetimeAmount: Double(row[7]) ?? 0.0,
            pledgeAmount: Double(row[8]) ?? 0.0,
            chargeFrequency: row[9].isEmpty ? nil : row[9],
            tier: row[10],
            addressee: row[11].isEmpty ? nil : row[11],
            street: row[12].isEmpty ? nil : row[12],
            city: row[13].isEmpty ? nil : row[13],
            state: row[14].isEmpty ? nil : row[14],
            zip: row[15].isEmpty ? nil : row[15],
            country: row[16].isEmpty ? nil : row[16],
            phone: row[17].isEmpty ? nil : row[17],
            patronageSinceDate: dateFormatter.date(from: row[18]) ?? Date(),
            lastChargeDate: dateFormatter.date(from: row[19]),
            lastChargeStatus: row[20].isEmpty ? nil : row[20],
            additionalDetails: row[21].isEmpty ? nil : row[21],
            userID: row[22],
            lastUpdated: dateFormatter.date(from: row[23]) ?? Date(),
            currency: row[24],
            maxPosts: Int(row[25]),
            accessExpiration: dateFormatter.date(from: row[26]),
            nextChargeDate: row.count > 27 ? dateFormatter.date(from: row[27]) : nil
        )
        
        subscribers.append(subscriber)
    }
    
    return subscribers
}

//func createSubscribersFromCSV(filePath: String) -> [Subscriber] {
//    var subscribers: [Subscriber] = []
//    
//    guard let content = try? String(contentsOfFile: filePath, encoding: .utf8) else {
//        print("Failed to read file at path: \(filePath)")
//        return []
//    }
//    
//    let rows = content.components(separatedBy: .newlines)
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//    
//    // Skip the header row
//    for row in rows.dropFirst() {
//        let columns = row.components(separatedBy: ",")
//        guard columns.count >= 27 else {
//            print("Row does not have enough columns: \(row)")
//            continue
//        } // Ensure we have all expected columns
//        
//        let subscriber = Subscriber(
//            name: columns[0],
//            email: columns[1],
//            discord: columns[2].isEmpty ? nil : columns[2],
//            patronStatus: columns[3].isEmpty ? nil : columns[3],
//            followsYou: columns[4] == "Yes",
//            freeMember: columns[5] == "Yes",
//            freeTrial: columns[6] == "Yes",
//            lifetimeAmount: Double(columns[7]) ?? 0.0,
//            pledgeAmount: Double(columns[8]) ?? 0.0,
//            chargeFrequency: columns[9].isEmpty ? nil : columns[9],
//            tier: columns[10],
//            addressee: columns[11].isEmpty ? nil : columns[11],
//            street: columns[12].isEmpty ? nil : columns[12],
//            city: columns[13].isEmpty ? nil : columns[13],
//            state: columns[14].isEmpty ? nil : columns[14],
//            zip: columns[15].isEmpty ? nil : columns[15],
//            country: columns[16].isEmpty ? nil : columns[16],
//            phone: columns[17].isEmpty ? nil : columns[17],
//            patronageSinceDate: dateFormatter.date(from: columns[18]) ?? Date(),
//            lastChargeDate: dateFormatter.date(from: columns[19]),
//            lastChargeStatus: columns[20].isEmpty ? nil : columns[20],
//            additionalDetails: columns[21].isEmpty ? nil : columns[21],
//            userID: columns[22],
//            lastUpdated: dateFormatter.date(from: columns[23]) ?? Date(),
//            currency: columns[24],
//            maxPosts: Int(columns[25]),
//            accessExpiration: dateFormatter.date(from: columns[26]),
//            nextChargeDate: dateFormatter.date(from: columns[27])
//        )
//        
//        subscribers.append(subscriber)
//    }
//    
//    return subscribers
//}
