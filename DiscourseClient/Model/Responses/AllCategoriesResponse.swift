import Foundation

struct AllCategoriesResponse: Codable {
    var categoryList: Categories

    enum CodingKeys: String, CodingKey {
        case categoryList = "category_list"
    }
}

struct Categories: Codable {
    var categories: [Category] = []
}

struct Category: Codable {
    let id: Int
    let name: String
}
