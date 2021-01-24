import UIKit

class UserListCoordinator: Coordinator {
    let presenter: UINavigationController
    let userListDataManager: UserListDataManager
    let userDataManager: UserDataManager

    init(presenter: UINavigationController, userListDataManager: UserListDataManager, userDataManager: UserDataManager) {
        self.presenter = presenter
        self.userListDataManager = userListDataManager
        self.userDataManager = userDataManager
    }

    override func start() {
        let userListViewModel = UserListViewModel(userDataManager: userListDataManager)
        let userListViewController = UserListViewController(viewModel: userListViewModel)
        userListViewModel.viewDelegate = userListViewController
        userListViewModel.coordinatorDelegate = self
        userListViewController.title = "Users"
        presenter.pushViewController(userListViewController, animated: false)
    }

    override func finish() {}
}

extension UserListCoordinator: UsersListCoordinatorDelegate {
    func didSelect(user: User) {
        let userCoordinator = UserCoordinator(presenter: presenter, userDataManager: userDataManager, userName: user.username)
        addChildCoordinator(userCoordinator)
        userCoordinator.start()

        userCoordinator.onBackTapped = { [weak self] in
            guard let self = self else { return }
            userCoordinator.finish()
            self.removeChildCoordinator(userCoordinator)
        }

        userCoordinator.onUserUpdate = {

            
        }
    }


}
