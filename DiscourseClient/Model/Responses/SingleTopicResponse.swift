import Foundation

struct SingleTopicResponse: Codable {
    var id: Int
    var title: String
    var details: topicDetails
}

struct topicDetails: Codable {
    var canDelete: Bool? = false

    enum CodingKeys: String, CodingKey {
        case canDelete = "can_delete"
    }
}
