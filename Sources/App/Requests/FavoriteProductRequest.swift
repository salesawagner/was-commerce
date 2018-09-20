//
//  FavoriteProductRequest.swift
//  App
//
//  Created by Wagner Sales on 18/09/18.
//

import Vapor

/// Struct de request de criar produto favorito do usuário que representa os parametros
struct FavoriteProductRequest: Content {
	
	/// ID do produto que será favoritado
	var productID: Int
}
