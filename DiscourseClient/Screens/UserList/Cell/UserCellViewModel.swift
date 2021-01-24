import Foundation

class UserCellViewModel {
    let user: User
    var textLabel: String?
    var avatarPath: String

    init(user: User) {
        self.user = user
        self.textLabel = user.username
        self.avatarPath = "\(apiURL)\(user.avatarTemplate)"
    }
}
