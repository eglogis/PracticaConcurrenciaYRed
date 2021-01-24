import UIKit

class AppCoordinator: Coordinator {
    let sessionAPI = SessionAPI()

    lazy var remoteDataManager: DiscourseClientRemoteDataManager = {
        let remoteDataManager = DiscourseClientRemoteDataManagerImpl(session: sessionAPI)
        return remoteDataManager
    }()

    lazy var dataManager: DiscourseClientDataManager = {
        let dataManager = DiscourseClientDataManager(remoteDataManager: self.remoteDataManager)
        return dataManager
    }()

    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }

    override func start() {
        let tabBarController = UITabBarController()

        let topicsNavigationController = UINavigationController()
        let topicsCoordinator = TopicsCoordinator(presenter: topicsNavigationController,
                                                  topicsDataManager: dataManager,
                                                  topicDetailDataManager: dataManager,
                                                  addTopicDataManager: dataManager)
        addChildCoordinator(topicsCoordinator)
        topicsCoordinator.start()

        let categoriesNavigationController = UINavigationController()
        let categoriesCoordinator = CategoriesCoordinator(presenter: categoriesNavigationController, categoryDataManager: dataManager)
        addChildCoordinator(categoriesCoordinator)
        categoriesCoordinator.start()

        let usersListNavigationController = UINavigationController()
        let userListCoordinator = UserListCoordinator(presenter: usersListNavigationController, userListDataManager: dataManager, userDataManager: dataManager)
        addChildCoordinator(userListCoordinator)
        userListCoordinator.start()

        tabBarController.tabBar.tintColor = .black

        tabBarController.viewControllers = [topicsNavigationController, categoriesNavigationController, usersListNavigationController]
        tabBarController.tabBar.items?.first?.image = UIImage(systemName: "list.dash")
        tabBarController.tabBar.items?[1].image = UIImage(systemName: "tag")
        tabBarController.tabBar.items?[2].image = UIImage(systemName: "person")


        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }

    override func finish() {}
}
