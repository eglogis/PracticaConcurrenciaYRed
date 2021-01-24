import Foundation

class TopicCellViewModel {
    let topic: Topic
    var textLabelText: String?
    
    init(topic: Topic) {
        self.topic = topic
        self.textLabelText = topic.title
    }
}
