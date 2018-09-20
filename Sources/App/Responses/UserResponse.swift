//
//  UserResponse.swift
//  App
//
//  Created by Wagner Sales on 16/09/18.
//

import Vapor

/// Struct de response do usuário
struct UserResponse: Content {

	/// ID do usuário
	var id: Int
	
	/// nome do usuário
	var name: String
	
	/// email do usuário
	var email: String

	init(user: User) {
		self.id = user.id
		self.name = user.name
		self.email = user.email
	}
}
