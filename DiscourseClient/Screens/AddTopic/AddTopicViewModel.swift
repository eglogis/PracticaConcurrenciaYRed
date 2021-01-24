import Foundation

protocol AddTopicCoordinatorDelegate: class {
    func addTopicCancelButtonTapped()
    func topicSuccessfullyAdded()
}

protocol AddTopicViewDelegate: class {
    func errorAddingTopic()
}

class AddTopicViewModel {
    weak var viewDelegate: AddTopicViewDelegate?
    weak var coordinatorDelegate: AddTopicCoordinatorDelegate?
    let addTopicDataManager: AddTopicDataManager

    init(dataManager: AddTopicDataManager) {
        self.addTopicDataManager = dataManager
    }

    func cancelButtonTapped() {
        coordinatorDelegate?.addTopicCancelButtonTapped()
    }

    func submitButtonTapped(title: String) {
        addTopicDataManager.addTopic(title: title, raw: title, createdAt: "") { [weak self] result in
            switch result {
                case .success( _):
                    self?.coordinatorDelegate?.topicSuccessfullyAdded()
                case .failure( _):
                    self?.viewDelegate?.errorAddingTopic()
            }
        }
    }
}
