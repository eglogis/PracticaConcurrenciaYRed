import Foundation

struct UserUpdateRequest: APIRequest {

    typealias Response = UserUpdateResponse

    let username: String
    let editName: String

    init(username: String, editName: String) {
        self.username = username
        self.editName = editName
    }

    var method: Method {
        return .PUT
    }

    var path: String {
        return "/users/\(username).json"
    }

    var parameters: [String : String] {
        return [:]
    }

    var body: [String : Any] {
        return ["name" : editName]
    }

    var headers: [String : String] {
        return [:]
    }
}
