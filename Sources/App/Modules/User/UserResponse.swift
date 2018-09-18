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
}

extension UserResponse {
	static func make(json: JSON) -> UserResponse? {

		guard let id = json["id"] as? Int, let name = json["name"] as? String, let email = json["email"] as? String else {
			return nil
		}
		
		return UserResponse(id: id, name: name, email: email)
	}
}
