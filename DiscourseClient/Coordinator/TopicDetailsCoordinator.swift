import UIKit

class TopicDetailCoordinator: Coordinator {
    let presenter: UINavigationController
    let topicDetailDataManager: TopicDetailDataManager
    var topicDetailNavigationController: UINavigationController?
    var topicId: Int
    var onBackTapped: (() -> Void)?
    var onTopicDelete: (() -> Void)?

    init(presenter: UINavigationController, topicDetailDataManager: TopicDetailDataManager, topicId: Int) {
        self.presenter = presenter
        self.topicDetailDataManager = topicDetailDataManager
        self.topicId = topicId
    }

    override func start() {
        let topicDetailViewModel = TopicDetailViewModel(topicID: topicId, topicDetailDataManager: topicDetailDataManager)

        topicDetailViewModel.coordinatorDelegate = self
        let topicDetailViewController = TopicDetailViewController(viewModel: topicDetailViewModel)
        topicDetailViewModel.viewDelegate = topicDetailViewController
        topicDetailViewController.isModalInPresentation = true
        topicDetailViewController.title = "Add topic"

        let navigationController = UINavigationController(rootViewController: topicDetailViewController)
        self.topicDetailNavigationController = navigationController
        presenter.present(navigationController, animated: true, completion: nil)
    }

    override func finish() {
        topicDetailNavigationController?.dismiss(animated: true, completion: nil)
    }
}

extension TopicDetailCoordinator: TopicDetailCoordinatorDelegate {
    func topicDeleteButtonTapped() {
        onTopicDelete?()
    }

    func topicDetailBackButtonTapped() {
        onBackTapped?()
    }
}
