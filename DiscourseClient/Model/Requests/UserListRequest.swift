import Foundation

struct UserListRequest: APIRequest {

    typealias Response = UserListResponse

    var method: Method {
        return .GET
    }

    var path: String {
        return "/directory_items.json"
    }

    var parameters: [String : String] {
        return ["period" : "all", "order": "likes_received"]
    }

    var body: [String : Any] {
        return [:]
    }

    var headers: [String : String] {
        return [:]
    }
}
