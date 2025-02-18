import UIKit
import Reusable
import Then

final class PhotosViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var photosMananger: PhotosManager!
    var coordinator: PhotosCoordinatorProtocol!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchPhotos()
    }
    
    // MARK: - Others
    private func setupView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Photos"
        
        tableView.do {
            $0.rowHeight = UITableView.automaticDimension
            $0.estimatedRowHeight = 90
            $0.dataSource = self
            $0.delegate = self
            $0.register(cellType: PhotoTableCell.self)
        }
    }
    
    func fetchPhotos() {
        photosMananger.fetchPhotos(
            success: { [weak self] in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            },
            failure: { [weak self] error in
                guard let self = self else { return }
                self.showErrorAlert(error: error)
            })
    }
    
    func gotoPhotoDetail(_ photo: PhotoEntity) {
        coordinator.gotoPhotoDetail(photo: photo)
    }
}

// MARK: - Tableview
extension PhotosViewController: UITableViewDataSource,
                      UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int)
    -> Int {
        return photosMananger.numberOfPhotos
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            for: indexPath, cellType: PhotoTableCell.self
        ).then {
            if let photo = photosMananger
                .photoAtIndex(indexPath.row) {
                $0.bindData(photo)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        if let photo = photosMananger.photoAtIndex(indexPath.row) {
            gotoPhotoDetail(photo)
        }
    }
}
