/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct OrderTrackingModelData : Codable {
	let id : Int?
	let user : OrderTrackingModelUser?
	let address : Address?
	let order_id : String?
	let order_price : Int?
	let final_price : Int?
	let fee_price : Int?
	let delivery_dayes : String?
	let delivery_shifts : String?
	let orderProducts : [OrderProducts]?
	let notes : String?
	let status : Int?
	let delivery : String?
	let created_at : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case user = "user"
		case address = "address"
		case order_id = "order_id"
		case order_price = "order_price"
		case final_price = "final_price"
		case fee_price = "fee_price"
		case delivery_dayes = "delivery_dayes"
		case delivery_shifts = "delivery_shifts"
		case orderProducts = "orderProducts"
		case notes = "notes"
		case status = "status"
		case delivery = "delivery"
		case created_at = "created_at"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		user = try values.decodeIfPresent(OrderTrackingModelUser.self, forKey: .user)
		address = try values.decodeIfPresent(Address.self, forKey: .address)
		order_id = try values.decodeIfPresent(String.self, forKey: .order_id)
		order_price = try values.decodeIfPresent(Int.self, forKey: .order_price)
		final_price = try values.decodeIfPresent(Int.self, forKey: .final_price)
		fee_price = try values.decodeIfPresent(Int.self, forKey: .fee_price)
		delivery_dayes = try values.decodeIfPresent(String.self, forKey: .delivery_dayes)
		delivery_shifts = try values.decodeIfPresent(String.self, forKey: .delivery_shifts)
		orderProducts = try values.decodeIfPresent([OrderProducts].self, forKey: .orderProducts)
		notes = try values.decodeIfPresent(String.self, forKey: .notes)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		delivery = try values.decodeIfPresent(String.self, forKey: .delivery)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
	}

}
struct Address: Codable {
    var id: Int?
    var address_title: String?
    var city: String?
    var neighborhood: String?
    var street_no: String?
    var building_no: String?
    var flat_no: String?
    var apartment_no: String?
    var notes: String?
    var user: String?
}
