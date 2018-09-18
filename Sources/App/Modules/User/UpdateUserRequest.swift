//
//  UpdateUserRequest.swift
//  App
//
//  Created by Wagner Sales on 18/09/18.
//

import Vapor

struct UpdateUserRequest: Content {
	var name: String
	var email: String
}

extension UpdateUserRequest {
	func toParameters() -> [String: Any] {
		
		var parameters: [String: Any] = [:]
		parameters["name"] = self.name
		parameters["email"] = self.email
		
		return parameters
	}
}
