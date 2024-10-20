//
//  UserModel.swift
//  swift-animated-barnacle
//
//  Created by m1_air on 10/20/24.
//

import Foundation

struct UserData: Codable, Equatable {
    var _id: String?
    var username: String
    var email: String
    var password: String
    var dateCreated: Date?
    var dateUpdated: Date?

    private enum CodingKeys: String, CodingKey {
        case _id
        case username
        case email
        case password
        case dateCreated
        case dateUpdated
    }

    // Decode Unix timestamp as Date
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        _id = try container.decodeIfPresent(String.self, forKey: ._id)
        username = try container.decode(String.self, forKey: .username)
        email = try container.decode(String.self, forKey: .email)
        password = try container.decode(String.self, forKey: .password)
       
        // Try decoding dateCreated and dateUpdated as Unix timestamps
        if let dateCreatedTimestamp = try container.decodeIfPresent(Double.self, forKey: .dateCreated) {
            dateCreated = Date(timeIntervalSince1970: dateCreatedTimestamp)
        }
        if let dateUpdatedTimestamp = try container.decodeIfPresent(Double.self, forKey: .dateUpdated) {
            dateUpdated = Date(timeIntervalSince1970: dateUpdatedTimestamp)
        }
    }

    // Encode Date as Unix timestamp
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(_id, forKey: ._id)
        try container.encode(username, forKey: .username)
        try container.encode(email, forKey: .email)
        try container.encode(password, forKey: .password)
        
        // Encode dates as Unix timestamps (seconds since 1970)
        if let dateCreated = dateCreated {
            try container.encode(dateCreated.timeIntervalSince1970, forKey: .dateCreated)
        }
        if let dateUpdated = dateUpdated {
            try container.encode(dateUpdated.timeIntervalSince1970, forKey: .dateUpdated)
        }
    }
    
    // Init method with default values
    init(_id: String = "", identifier: Double = 0, online: Bool = false, username: String = "", email: String = "", password: String = "", avatar: String = "", uploads: [String] = [], longitude: Double = 0.0, latitude: Double = 0.0, dateCreated: Date? = nil, dateUpdated: Date? = nil) {
        self._id = _id
        self.username = username
        self.email = email
        self.password = password
        self.dateCreated = dateCreated
        self.dateUpdated = dateUpdated
    }
}
