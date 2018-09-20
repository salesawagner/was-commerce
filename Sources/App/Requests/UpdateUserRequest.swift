//
//  UpdateUserRequest.swift
//  App
//
//  Created by Wagner Sales on 18/09/18.
//

import Vapor

/// Struct de request de atualização de usuário que representa os parametros
struct UpdateUserRequest: Content {
	
	/// Novo nome do usuário
	var name: String
	
	/// Novo email do usuário
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
