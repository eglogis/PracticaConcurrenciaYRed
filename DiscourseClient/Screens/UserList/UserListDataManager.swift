import Foundation

enum UserListDataManagerError: Error {
    case unknown
}

protocol UserListDataManager {
    func fetchUsers(completion: @escaping (Result<UserListResponse?, Error>) -> ())
}
