import Foundation

protocol UserListViewDelegate: class {
    func usersFetched()
    func errorFetchingUser()
}

protocol UsersListCoordinatorDelegate: class {
    func didSelect(user: User)
}

class UserListViewModel {
    weak var coordinatorDelegate: UsersListCoordinatorDelegate?
    weak var viewDelegate: UserListViewDelegate?
    let userDataManager: UserListDataManager
    var userCellViewModels: [UserCellViewModel] = []

    init(userDataManager: UserListDataManager) {
        self.userDataManager = userDataManager
    }

    func viewWasLoaded() {
        getAllUsers()
    }

    func numberOfSections() -> Int {
        return 1
    }
    func numberOfRows(in section: Int) -> Int {
        return userCellViewModels.count
    }

    func viewModel(at indexPath: IndexPath) -> UserCellViewModel? {
        guard indexPath.row < userCellViewModels.count else { return nil }
        return userCellViewModels[indexPath.row]
    }

    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < userCellViewModels.count else { return }
        coordinatorDelegate?.didSelect(user: userCellViewModels[indexPath.row].user)
    }

    private func getAllUsers() {
        userDataManager.fetchUsers { [weak self] (result) in
            switch result {
                case .success(let allUserResponse):
                    guard let vm = allUserResponse?.directoryItem.map({ directory ->
                        UserCellViewModel in
                        return UserCellViewModel(user: directory.user)
                    }) else { return }

                    self?.userCellViewModels = vm
                    self?.viewDelegate?.usersFetched()

                case .failure(let error):
                    self?.viewDelegate?.errorFetchingUser()
                    print(error)
            }
        }
    }

}
