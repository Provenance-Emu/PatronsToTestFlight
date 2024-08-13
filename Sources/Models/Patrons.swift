//
//  Model.swift
//  patreon-subs
//
//  Created by Joseph Mattiello on 8/13/24.
//


import Foundation
import SwiftData

//@Model
final class Subscriber: Identifiable {
    
    // @Attribute(.unique)
    var name: String
    // @Attribute(.unique)
    var email: String
    
    var discord: String?
    
    var patronStatus: String?
    var followsYou: Bool
    var freeMember: Bool
    var freeTrial: Bool
    var lifetimeAmount: Double
    var pledgeAmount: Double

    var chargeFrequency: String?
    var tier: String
    
    var addressee: String?
    var street: String?
    var city: String?
    var state: String?
    var zip: String?
    var country: String?
    var phone: String?
    
    var patronageSinceDate: Date
    
    var lastChargeDate: Date?
    var lastChargeStatus: String?
    
    var additionalDetails: String?
    
    // @Attribute(.unique)
    var userID: String
    
    var lastUpdated: Date
    var currency: String
    
    var maxPosts: Int?
    
    var accessExpiration: Date?
    var nextChargeDate: Date?
    
    init(name: String, email: String, discord: String? = nil, patronStatus: String? = nil, followsYou: Bool, freeMember: Bool, freeTrial: Bool, lifetimeAmount: Double, pledgeAmount: Double, chargeFrequency: String? = nil, tier: String, addressee: String? = nil, street: String? = nil, city: String? = nil, state: String? = nil, zip: String? = nil, country: String? = nil, phone: String? = nil, patronageSinceDate: Date, lastChargeDate: Date? = nil, lastChargeStatus: String? = nil, additionalDetails: String? = nil, userID: String, lastUpdated: Date, currency: String, maxPosts: Int? = nil, accessExpiration: Date? = nil, nextChargeDate: Date? = nil) {
        self.name = name
        self.email = email
        self.discord = discord
        self.patronStatus = patronStatus
        self.followsYou = followsYou
        self.freeMember = freeMember
        self.freeTrial = freeTrial
        self.lifetimeAmount = lifetimeAmount
        self.pledgeAmount = pledgeAmount
        self.chargeFrequency = chargeFrequency
        self.tier = tier
        self.addressee = addressee
        self.street = street
        self.city = city
        self.state = state
        self.zip = zip
        self.country = country
        self.phone = phone
        self.patronageSinceDate = patronageSinceDate
        self.lastChargeDate = lastChargeDate
        self.lastChargeStatus = lastChargeStatus
        self.additionalDetails = additionalDetails
        self.userID = userID
        self.lastUpdated = lastUpdated
        self.currency = currency
        self.maxPosts = maxPosts
        self.accessExpiration = accessExpiration
        self.nextChargeDate = nextChargeDate
    }
    
    var id: String { userID }
}

