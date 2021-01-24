import Foundation

protocol TopicsCoordinatorDelegate: class {
    func didSelect(topic: Topic)
    func topicsPlusButtonTapped()
}

protocol TopicsViewDelegate: class {
    func topicsFetched()
    func errorFetchingTopics()
}

class TopicsViewModel {
    weak var coordinatorDelegate: TopicsCoordinatorDelegate?
    weak var viewDelegate: TopicsViewDelegate?
    let topicsDataManager: TopicsDataManager
    var topicViewModels: [TopicCellViewModel] = []

    init(topicsDataManager: TopicsDataManager) {
        self.topicsDataManager = topicsDataManager
    }

    func viewWasLoaded() {
        getAllTopics()
    }

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRows(in section: Int) -> Int {
        return topicViewModels.count
    }

    func viewModel(at indexPath: IndexPath) -> TopicCellViewModel? {
        guard indexPath.row < topicViewModels.count else { return nil }
        return topicViewModels[indexPath.row]
    }

    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < topicViewModels.count else { return }
        coordinatorDelegate?.didSelect(topic: topicViewModels[indexPath.row].topic)
    }

    func plusButtonTapped() {
        coordinatorDelegate?.topicsPlusButtonTapped()
    }

    func updateTopics() {
        getAllTopics()
    }

    private func getAllTopics() {
        topicsDataManager.fetchAllTopics { [weak self] (result) in
            switch result {
                case .success(let latestTopicResponse):
                    guard let vm = latestTopicResponse?.topicList.topics.map({ topic ->
                        TopicCellViewModel in
                        return TopicCellViewModel(topic: topic)
                    }) else { return }

                    self?.topicViewModels = vm
                    self?.viewDelegate?.topicsFetched()

                case .failure(let error):
                    self?.viewDelegate?.errorFetchingTopics()
                    print(error)
            }
        }
    }
}
