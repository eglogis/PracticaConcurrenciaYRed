import UIKit

class CategoriesCoordinator: Coordinator {
    let presenter: UINavigationController
    let categoryDataManager: CategoriesDataManager

    init(presenter: UINavigationController, categoryDataManager: CategoriesDataManager) {
        self.presenter = presenter
        self.categoryDataManager = categoryDataManager
    }

    override func start() {
        let categoriesViewModel = CategoriesViewModel(categoryDataManager: categoryDataManager)
        let categoriesViewController = CategoriesViewController(viewModel: categoriesViewModel)
        categoriesViewModel.viewDelegate = categoriesViewController
        categoriesViewController.title = NSLocalizedString("Categories", comment: "")
        presenter.pushViewController(categoriesViewController, animated: false)
    }
    
    override func finish() {}
}
