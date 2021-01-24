import Foundation

class DiscourseClientDataManager {
    let remoteDataManager: DiscourseClientRemoteDataManager

    init(remoteDataManager: DiscourseClientRemoteDataManager) {
        self.remoteDataManager = remoteDataManager
    }
}

extension DiscourseClientDataManager: TopicsDataManager {
    func fetchAllTopics(completion: @escaping (Result<LatestTopicsResponse?, Error>) -> ()) {
        remoteDataManager.fetchAllTopics(completion: completion)
    }
}

extension DiscourseClientDataManager: TopicDetailDataManager {
    func deleteTopic(id: Int, completion: @escaping (Result<DeleteTopicResponse?, Error>) -> ()) {
        remoteDataManager.deleteTopic(id: id, completion: completion)
    }

    func fetchTopic(id: Int, completion: @escaping (Result<SingleTopicResponse?, Error>) -> ()) {
        remoteDataManager.fetchTopic(id: id, completion: completion)
    }
}

extension DiscourseClientDataManager: AddTopicDataManager {
    func addTopic(title: String, raw: String, createdAt: String, completion: @escaping (Result<AddNewTopicResponse?, Error>) -> ()) {
        remoteDataManager.addTopic(title: title, raw: raw, createdAt: createdAt, completion: completion)
    }
}

extension DiscourseClientDataManager: CategoriesDataManager {
    func fetchAllCategories(completion: @escaping (Result<AllCategoriesResponse?, Error>) -> ()) {
        remoteDataManager.fetchAllCategories(completion: completion)
    }
}

extension DiscourseClientDataManager: UserListDataManager {
    func fetchUsers(completion: @escaping (Result<UserListResponse?, Error>) -> ()) {
        remoteDataManager.fetchUsers(completion: completion)
    }
}

extension DiscourseClientDataManager: UserDataManager {
    func updateUser(username: String, editName: String, completion: @escaping (Result<UserUpdateResponse?, Error>) -> ()) {
        remoteDataManager.updateUser(username: username, editName: editName, completion: completion)
    }

    func fetchUser(username: String, completion: @escaping (Result<UserResponse?, Error>) -> ()) {
        remoteDataManager.fetchUser(username: username, completion: completion)
    }
}

