import Foundation

struct AllCategoriesRequest: APIRequest {

    typealias Response = AllCategoriesResponse

    var method: Method {
        return .GET
    }

    var path: String {
        return "/categories.json"
    }

    var parameters: [String : String] {
        return [:]
    }

    var body: [String : Any] {
        return [:]
    }

    var headers: [String : String] {
        return [:]
    }
}
