import Foundation

protocol UserCoordinatorDelegate: class {
    func userDetailBackButtonTapped()
    func userUpdateButtonTapped()
}

protocol UserViewDelegate: class {
    func userDetailFetched(id: Int, name: String, canUpdate: Bool)
    func userUpdateFetched()
    func userUpdateError()

    func userDetailFetchedError()
}

class UserViewModel {
    weak var viewDelegate: UserViewDelegate?

    weak var coordinatorDelegate: UserCoordinatorDelegate?

    let userDataManager: UserDataManager
    let userName: String

    init(userName: String, userDataManager: UserDataManager) {
        self.userName = userName
        self.userDataManager = userDataManager
    }

    func viewDidLoad() {
        getUser()
    }

    func backButtonTapped() {
        coordinatorDelegate?.userDetailBackButtonTapped()
    }

    func updateButtonTapped(labelName: String) {
        updateUser(labelName: labelName)
    }

    private func getUser() {
        userDataManager.fetchUser(username: userName) { [weak self] result in
            switch result {
                case .success(let userResponse):
                    guard let user = userResponse else { return }
                    self?.viewDelegate?.userDetailFetched(id: user.user.id, name: user.user.name ?? "", canUpdate: user.user.canEdit ?? false)
                case .failure(let error):
                    self?.viewDelegate?.userDetailFetchedError()
                    print(error)
            }
        }
    }

    private func updateUser(labelName: String) {

        userDataManager.updateUser(username: userName, editName: labelName) { [weak self] result in
            switch result {
                case .success(let updateUserResponse):
                    guard let response = updateUserResponse else { return }
                    if(response.success == "OK") {
                        self?.viewDelegate?.userUpdateFetched()

                    } else {
                        self?.viewDelegate?.userUpdateError()
                    }

                case .failure(let error):
                    self?.viewDelegate?.userUpdateError()
                    print(error)
            }
        }
    }
}
