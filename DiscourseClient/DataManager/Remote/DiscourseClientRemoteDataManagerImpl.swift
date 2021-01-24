import Foundation

class DiscourseClientRemoteDataManagerImpl: DiscourseClientRemoteDataManager {

    let session: SessionAPI

    init(session: SessionAPI) {
        self.session = session
    }

    func fetchAllTopics(completion: @escaping (Result<LatestTopicsResponse?, Error>) -> ()) {
        let request = LatestTopicsRequest()
        session.send(request: request) { result in
            completion(result)
        }
    }

    func fetchTopic(id: Int, completion: @escaping (Result<SingleTopicResponse?, Error>) -> ()) {
        let request = SingleTopicRequest(id: id)
        session.send(request: request) { result in
            completion(result)
        }
    }

    func addTopic(title: String, raw: String, createdAt: String, completion: @escaping (Result<AddNewTopicResponse?, Error>) -> ()) {
        let request = CreateTopicRequest(title: title, raw: raw, createdAt: createdAt)
        session.send(request: request) { result in
            completion(result)
        }
    }

    func fetchAllCategories(completion: @escaping (Result<AllCategoriesResponse?, Error>) -> ()) {
        let request = AllCategoriesRequest()
        session.send(request: request) { result in
            completion(result)
        }
    }

    func fetchUsers(completion: @escaping (Result<UserListResponse?, Error>) -> ()) {
        let request = UserListRequest()
        session.send(request: request) { result in
            completion(result)
        }
    }

    func deleteTopic(id: Int, completion: @escaping (Result<DeleteTopicResponse?, Error>) -> ()) {
        let request = DeleteTopicRequest(id: id)
        session.send(request: request) { result in
            completion(result)
        }
    }

    func fetchUser(username: String, completion: @escaping (Result<UserResponse?, Error>) -> ()) {
        let request = UserRequest(username: username)
        session.send(request: request) { result in
            completion(result)
        }
    }

    func updateUser(username: String, editName: String, completion: @escaping (Result<UserUpdateResponse?, Error>) -> ()) {
        let request = UserUpdateRequest(username: username, editName: editName)
        session.send(request: request) { result in
            completion(result)
        }
    }
}
