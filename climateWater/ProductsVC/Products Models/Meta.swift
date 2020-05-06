/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Meta : Codable {
	let current_page : Int?
	let from : Int?
	let last_page : Int?
	let path : String?
	let per_page : Int?
	let to : Int?
	let total : Int?

	enum CodingKeys: String, CodingKey {

		case current_page = "current_page"
		case from = "from"
		case last_page = "last_page"
		case path = "path"
		case per_page = "per_page"
		case to = "to"
		case total = "total"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		current_page = try values.decodeIfPresent(Int.self, forKey: .current_page)
		from = try values.decodeIfPresent(Int.self, forKey: .from)
		last_page = try values.decodeIfPresent(Int.self, forKey: .last_page)
		path = try values.decodeIfPresent(String.self, forKey: .path)
		per_page = try values.decodeIfPresent(Int.self, forKey: .per_page)
		to = try values.decodeIfPresent(Int.self, forKey: .to)
		total = try values.decodeIfPresent(Int.self, forKey: .total)
	}

}