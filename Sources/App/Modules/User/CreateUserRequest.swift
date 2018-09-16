//
//  CreateUserRequest.swift
//  App
//
//  Created by Wagner Sales on 16/09/18.
//

import Foundation
import Vapor

struct CreateUserRequest: Content {
	/// User's full name.
	var name: String
	
	/// User's email address.
	var email: String
	
	/// User's desired password.
	var password: String
	
	/// User's password repeated to ensure they typed it correctly.
	var verifyPassword: String
}
