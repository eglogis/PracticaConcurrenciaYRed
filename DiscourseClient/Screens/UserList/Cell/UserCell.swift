import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var cellImageView: UIImageView?

    var viewModel: UserCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            textLabel?.text = viewModel.textLabel
            let completePath = viewModel.avatarPath.replacingOccurrences(of: "{size}", with: "50")
            ImageUtils.getImageFromUrl(url: completePath, completion: { image in
                print("main")
                self.cellImageView?.image = image
            })
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        cellImageView?.image = UIImage(systemName: "person")
    }
}
