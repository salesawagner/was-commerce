//
//  CreateCartRequest.swift
//  App
//
//  Created by Wagner Sales on 20/09/18.
//

import Vapor

/// Struct de request para adicionar um produto ao carrinho de compras que representa os parametros
struct CreateCartRequest: Content {
	
	/// ID do produto
	var productID: Int
}
