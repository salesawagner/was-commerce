//
//  LoginRequest.swift
//  App
//
//  Created by Wagner Sales on 18/09/18.
//

import Vapor

struct LoginRequest: Content {
	var username: String
	var password: String
}
