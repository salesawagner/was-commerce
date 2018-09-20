//
//  LoginRequest.swift
//  App
//
//  Created by Wagner Sales on 18/09/18.
//

import Vapor

/// Struct de request de fazer login do usuário que representa os parametros
struct LoginRequest: Content {
	
	/// Nome do usuário
	var username: String
	
	/// Senha do usuário
	var password: String
}
