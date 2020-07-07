//
//  Response.swift
//  Simple Enrollment
//
//  Created by Alexander Roca on 7/6/20.
//  Copyright © 2020 Alexander Roca. All rights reserved.
//

import Foundation


struct Response: Codable {
    let success: String
    let reason: String
    
    enum CodingKeys: String, CodingKey {
      case success
      case reason
    }
}
