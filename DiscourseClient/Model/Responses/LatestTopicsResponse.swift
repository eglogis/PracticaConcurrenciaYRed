import Foundation

struct LatestTopicsResponse: Codable {
    var topicList: LatestTopics

    enum CodingKeys: String, CodingKey {
        case topicList = "topic_list"
    }
}

struct LatestTopics: Codable {
    var topics: [Topic] = []
}

struct Topic: Codable {
    let id: Int
    let title: String
}
