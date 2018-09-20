//
//  BillingMicroService.swift
//  App
//
//  Created by Wagner Sales on 20/09/18.
//

import Foundation

class BillingMicroService {
	class func create(userID: Int? = nil, productID: Int) -> JSON {
		return Mock.JSONProduct
	}
	class func list(userID: Int? = nil) -> JSON {
		return Mock.JSONProductList
	}
}
