import UIKit

extension UIViewController {
    func showErrorAlert(error: Error?) {
        let error = error ?? APIError.unknownError
        let alertController = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}
