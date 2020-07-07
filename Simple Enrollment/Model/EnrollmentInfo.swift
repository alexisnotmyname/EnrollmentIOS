//
//  EnrollmentInfo.swift
//  Simple Enrollment
//
//  Created by Alexander Roca on 7/5/20.
//  Copyright © 2020 Alexander Roca. All rights reserved.
//

import Foundation

struct EnrollmentInfo: Codable {
    let idNo: String
    let firstName: String
    let lastName: String
    let mobile: String
    let address: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
      case idNo
      case firstName
      case lastName
      case mobile
      case address
      case imageUrl
    }
}
