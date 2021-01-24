import Foundation

protocol CategoryViewDelegate: class {
    func categoryFetched()
    func errorFetchingCategory()
}

class CategoriesViewModel {
    weak var viewDelegate: CategoryViewDelegate?
    let categoryDataManager: CategoriesDataManager
    var categoryCellViewModels: [CategoryCellViewModel] = []

    init(categoryDataManager: CategoriesDataManager) {
        self.categoryDataManager = categoryDataManager
    }

    func viewWasLoaded() {
        getAllCategories()
    }

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRows(in section: Int) -> Int {
        return categoryCellViewModels.count
    }

    func viewModel(at indexPath: IndexPath) -> CategoryCellViewModel? {
        guard indexPath.row < categoryCellViewModels.count else { return nil }
        return categoryCellViewModels[indexPath.row]
    }

    private func getAllCategories() {
        categoryDataManager.fetchAllCategories { [weak self] (result) in
            switch result {
                case .success(let allCategoryResponse):
                    guard let vm = allCategoryResponse?.categoryList.categories.map({ category ->
                        CategoryCellViewModel in
                        return CategoryCellViewModel(category: category)
                    }) else { return }

                    self?.categoryCellViewModels = vm
                    self?.viewDelegate?.categoryFetched()

                case .failure(let error):
                    self?.viewDelegate?.errorFetchingCategory()
                    print(error)
            }
        }
    }
}
