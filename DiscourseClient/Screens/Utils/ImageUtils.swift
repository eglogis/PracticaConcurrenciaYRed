import Foundation
import UIKit

class ImageUtils {

    static func getImageFromUrl(url: String, completion: @escaping (UIImage) -> ()) {
        guard let imageUrl: URL = URL(string: url) else { return }
        DispatchQueue.global(qos: .userInitiated).async {
            guard let imageData: Data = try? Data(contentsOf: imageUrl) else { return }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                completion(image ?? UIImage())
            }
        }
    }
}
