import Foundation

protocol UserDataManager: class {

    func fetchUser(username: String, completion: @escaping (Result<UserResponse?, Error>) -> ())
    func updateUser(username: String, editName: String, completion: @escaping (Result<UserUpdateResponse?, Error>) -> ())

}
