import UIKit

final class PhotoViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Variables
    var coordinator: PhotoCoordinator
    var photo: PhotoEntity
    
    // MARK: - init
    init(photo: PhotoEntity,
         coordinator: PhotoCoordinator) {
        self.photo = photo
        self.coordinator = coordinator
        super.init(nibName: "PhotoViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Others
    private func setupView() {
        photoImageView.sd_setImage(with: URL(string: photo.newUrl))
        titleLabel.text = photo.title
    }
}
