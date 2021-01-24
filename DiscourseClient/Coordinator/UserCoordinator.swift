import UIKit

class UserCoordinator: Coordinator {
    let presenter: UINavigationController
    let userDataManager: UserDataManager
    var userNavigationController: UINavigationController?
    var userName: String
    var onBackTapped: (() -> Void)?
    var onUserUpdate: (() -> Void)?

    init(presenter: UINavigationController, userDataManager : UserDataManager, userName: String) {
        self.presenter = presenter
        self.userDataManager = userDataManager
        self.userName = userName
    }

    override func start() {
        let userViewModel = UserViewModel(userName: userName, userDataManager: userDataManager)

        userViewModel.coordinatorDelegate = self
        let userViewController = UserViewController(viewModel: userViewModel)
        userViewModel.viewDelegate = userViewController
        userViewController.isModalInPresentation = true
        userViewController.title = "User Detail"

        let navigationController = UINavigationController(rootViewController: userViewController)
        self.userNavigationController = navigationController
        presenter.present(navigationController, animated: true, completion: nil)
    }

    override func finish() {
        userNavigationController?.dismiss(animated: true, completion: nil)
    }
}

extension UserCoordinator: UserCoordinatorDelegate {
    func userDetailBackButtonTapped() {
        onBackTapped?()
    }

    func userUpdateButtonTapped() {
        onUserUpdate?()
    }
}
