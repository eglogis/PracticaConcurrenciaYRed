import Foundation

protocol TopicDetailCoordinatorDelegate: class {
    func topicDetailBackButtonTapped()
    func topicDeleteButtonTapped()
}

protocol TopicDetailViewDelegate: class {
    func topicDetailFetched(title: String, id: Int, canDelete: Bool)
    func errorFetchingTopicDetail()
    func errorDeleteTopic()

}

class TopicDetailViewModel {
    var labelTopicIDText: String?
    var labelTopicNameText: String?

    weak var viewDelegate: TopicDetailViewDelegate?
    weak var coordinatorDelegate: TopicDetailCoordinatorDelegate?
    let topicDetailDataManager: TopicDetailDataManager
    let topicID: Int

    init(topicID: Int, topicDetailDataManager: TopicDetailDataManager) {
        self.topicID = topicID
        self.topicDetailDataManager = topicDetailDataManager
    }

    func viewDidLoad() {
        getTopic()
    }

    func backButtonTapped() {
        coordinatorDelegate?.topicDetailBackButtonTapped()
    }

    func deleteButtonTapped() {
        deleteTopic()
    }

    func getTopic() {
        topicDetailDataManager.fetchTopic(id: topicID) { [weak self] result in
            switch result {
                case .success(let topicDetailResponse):
                    guard let topic = topicDetailResponse else { return }
                    self?.viewDelegate?.topicDetailFetched(title: topic.title, id: topic.id, canDelete: topic.details.canDelete ?? false)
                case .failure( _):
                    self?.viewDelegate?.errorFetchingTopicDetail()
            }
        }
    }

    func deleteTopic() {
        topicDetailDataManager.deleteTopic(id: topicID) { [weak self] result in
            switch result {
                case .success( _):
                    self?.coordinatorDelegate?.topicDeleteButtonTapped()
                case .failure(let error):
                    self?.viewDelegate?.errorDeleteTopic()
                    print(error)
            }
        }
    }
}
