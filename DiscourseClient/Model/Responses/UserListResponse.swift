import Foundation

struct UserListResponse: Codable {
    var directoryItem: [Directory]

    enum CodingKeys: String, CodingKey {
        case directoryItem = "directory_items"
    }
}

struct Directory: Codable {
    var user: User
}

struct User: Codable {
    let id: Int
    let username: String
    let avatarTemplate: String
    let canEdit: Bool?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id, username, name
        case avatarTemplate = "avatar_template"
        case canEdit = "can_edit"
    }
}
