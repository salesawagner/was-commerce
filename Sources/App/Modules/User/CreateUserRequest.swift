//
//  CreateUserRequest.swift
//  App
//
//  Created by Wagner Sales on 16/09/18.
//

import Foundation
import Vapor
import Crypto

struct CreateUserRequest: Content {
	var name: String
	var email: String
	var password: String
	var verifyPassword: String
}

extension CreateUserRequest {
	func toParameters() -> [String: Any] {

		var parameters: [String: Any] = [:]
		parameters["name"] = self.name
		parameters["email"] = self.email
		parameters["password"] =  try? BCrypt.hash(self.password)
		parameters["verifyPassword"] =  try? BCrypt.hash(self.verifyPassword)

		return parameters
	}
}
