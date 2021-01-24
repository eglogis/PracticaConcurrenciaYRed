import UIKit

class UserViewController: UIViewController {

    lazy var labelUserId: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var labelUserName: UITextField = {
        let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var userIDStackView: UIStackView = {
        let labelUserIDTitle = UILabel()
        labelUserIDTitle.translatesAutoresizingMaskIntoConstraints = false
        labelUserIDTitle.text = NSLocalizedString("User ID: ", comment: "")
        labelUserIDTitle.textColor = .black

        let userIDStackView = UIStackView(arrangedSubviews: [labelUserIDTitle, labelUserId])
        userIDStackView.translatesAutoresizingMaskIntoConstraints = false
        userIDStackView.axis = .horizontal

        return userIDStackView
    }()

    var editBarButtonItem = UIBarButtonItem()

    lazy var userNameStackView: UIStackView = {
        let labelUserTitleTitle = UILabel()
        labelUserTitleTitle.text = NSLocalizedString("User name: ", comment: "")
        labelUserTitleTitle.translatesAutoresizingMaskIntoConstraints = false

        let userNameStackView = UIStackView(arrangedSubviews: [labelUserTitleTitle, labelUserName])
        userNameStackView.translatesAutoresizingMaskIntoConstraints = false
        userNameStackView.axis = .horizontal

        return userNameStackView
    }()

    let viewModel: UserViewModel

    init(viewModel: UserViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        view.addSubview(userIDStackView)
        NSLayoutConstraint.activate([
            userIDStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            userIDStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])

        view.addSubview(userNameStackView)
        NSLayoutConstraint.activate([
            userNameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            userNameStackView.topAnchor.constraint(equalTo: userIDStackView.bottomAnchor, constant: 8)
        ])

        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        leftBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = leftBarButtonItem

        editBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(updateButtonTapped))
        editBarButtonItem.tintColor = .blue
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }

    @objc func backButtonTapped() {
        viewModel.backButtonTapped()
    }

    @objc func updateButtonTapped() {
        viewModel.updateButtonTapped(labelName: labelUserName.text ?? "")
    }

    fileprivate func showErrorUserAlert(title: String) {
        let alertMessage: String = NSLocalizedString(title, comment: "")
        showAlert(alertMessage)
    }

    fileprivate func showSuccessUserAlert(title: String) {
        let alertMessage: String = NSLocalizedString("Success!", comment: "")
        showAlert(alertMessage)
    }
}

extension UserViewController: UserViewDelegate {
    func userUpdateFetched() {
        showSuccessUserAlert(title: "Update success!")
    }

    func userUpdateError() {
        showErrorUserAlert(title: "Error update user\nPlease try again later")
    }

    func userDetailFetchedError() {
        showErrorUserAlert(title: "Error fetching user detail\nPlease try again later")
    }

    func userDetailFetched(id: Int, name: String, canUpdate: Bool) {
        labelUserId.text = String(id)
        labelUserName.text = name
        labelUserName.isUserInteractionEnabled = canUpdate
        navigationItem.rightBarButtonItem = canUpdate ? editBarButtonItem : nil
    }
}
