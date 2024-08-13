//
//  TestFlighter.swift
//  patreon-subs
//
//  Created by Joseph Mattiello on 8/13/24.
//

import Foundation
import SwiftData

@Model
final class TestFlighter: Identifiable {
    var firstName: String
    var lastName: String
    @Attribute(.unique) var email: String
    
    init(firstName: String, lastName: String, email: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
}

extension TestFlighter {
    convenience init(withPatron patron: Subscriber) {
        let nameComponents = patron.name.split(separator: " ")
        let firstName = nameComponents.first.map(String.init) ?? ""
        let lastName = nameComponents.dropFirst().joined(separator: " ")

        self.init(firstName: firstName, lastName: lastName, email: patron.email)
    }
}
