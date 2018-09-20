//
//  CreateUserRequest.swift
//  App
//
//  Created by Wagner Sales on 16/09/18.
//

import Vapor
import Crypto

/// Struct de request de criar usuário que representa os parametros
struct CreateUserRequest: Content {
	
	/// nome do usuário
	var name: String
	
	/// email do usuário
	var email: String

	/// password do usuário
	var password: String
	
	/// verificação de password do usuário
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
