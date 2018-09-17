//
//  UserResponse.swift
//  App
//
//  Created by Wagner Sales on 16/09/18.
//

import Foundation
import Vapor

struct UserResponse: Content {
	var id: Int?
	var name: String
	var email: String
}
