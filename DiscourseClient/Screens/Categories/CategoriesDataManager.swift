import Foundation

enum CategoriesDataManagerError: Error {
    case unknown
}

protocol CategoriesDataManager {
    func fetchAllCategories(completion: @escaping (Result<AllCategoriesResponse?, Error>) -> ())
}
