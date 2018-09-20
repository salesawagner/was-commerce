//
//  UserResponse.swift
//  App
//
//  Created by Wagner Sales on 16/09/18.
//

import Vapor

struct UserResponse: Content {

	var id: Int
	var name: String
	var email: String

	init(user: User) {
		self.id = user.id
		self.name = user.name
		self.email = user.email
	}
}
