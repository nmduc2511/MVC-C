import UIKit
import SnapKit
import Reusable
import SDWebImage

final class PhotoTableCell: UITableViewCell, Reusable {
    let avaImgView = UIImageView()
    let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupViews() {
        self.do {
            $0.selectionStyle = .none
            addSubview(avaImgView)
            addSubview(titleLabel)
        }
        
        // image-view
        avaImgView.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.leading.equalTo(16)
            make.top.equalTo(20).priority(.medium)
            make.bottom.equalTo(-20).priority(.medium)
            make.centerY.equalToSuperview()
        }
        
        avaImgView.do {
            $0.layer.cornerRadius = 30
            $0.contentMode = .scaleAspectFit
            $0.clipsToBounds = true
        }
        
        // label
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(avaImgView.snp.trailing).offset(16)
            make.trailing.equalTo(-16)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.do {
            $0.text = ""
            $0.textColor = .black
            $0.numberOfLines = 2
        }
    }
    
    func bindData(_ photo: PhotoEntity) {
        titleLabel.text = photo.title
        avaImgView.sd_setImage(with: URL(string: photo.newThumbnailUrl))
    }
}
