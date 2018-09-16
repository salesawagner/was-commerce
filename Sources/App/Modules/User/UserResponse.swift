//
//  UserResponse.swift
//  App
//
//  Created by Wagner Sales on 16/09/18.
//

import Foundation
import Vapor

struct UserResponse: Content {
	/// User's unique identifier.
	/// Not optional since we only return users that exist in the DB.
	var id: Int
	
	/// User's full name.
	var name: String
	
	/// User's email address.
	var email: String
}
