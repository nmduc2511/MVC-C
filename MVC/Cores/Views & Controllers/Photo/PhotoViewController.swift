import UIKit

final class PhotoViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Variables
    var coordinator: PhotoCoordinator!
    var photo: PhotoEntity!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Others
    func setupView() {
        photoImageView.sd_setImage(with: URL(string: photo.newUrl))
        titleLabel.text = photo.title
    }
}
