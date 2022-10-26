//
//  GalleryCollectionViewCell.swift
//  IN SOPT KakaoTalk
//
//  Created by 장석우 on 2022/10/25.
//

import UIKit
import SnapKit

protocol GalleryCollectionViewCellDelegate {
    func cellStateChanged(indexPath: IndexPath, _ isSelected: Bool)
}

class GalleryCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties

    var delegate : GalleryCollectionViewCellDelegate?
    var indexPath : IndexPath?
    var isSelectedImage = false
    var orderOfSelectedImage : Int?
    
    //MARK: - UI Components
    
    private let imageView : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.layer.borderWidth = 3
        imgView.layer.borderColor = UIColor.clear.cgColor
        imgView.clipsToBounds = true
        imgView.isUserInteractionEnabled = true
        return imgView
    }()
    
    private lazy var indexButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        button.backgroundColor = .systemGray6
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.cornerRadius = button.bounds.width / 2
        button.clipsToBounds = true
        button.alpha = 0.7
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.addTarget(self, action: #selector(indexButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    
    private func setLayout(){
        contentView.addSubview(imageView)
        imageView.addSubview(indexButton)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        indexButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(7)
            $0.trailing.equalToSuperview().inset(7)
            $0.height.width.equalTo(25)
        }
    }
    
    func dataBind(_ data: UIImage?){
        imageView.image = data
        setSelectedCell()
    }
    
    private func setSelectedCell(){
        
        if isSelectedImage {
            imageView.layer.borderColor = UIColor.kakaoYellow.cgColor
            
            indexButton.layer.borderColor = UIColor.kakaoYellow.cgColor
            indexButton.backgroundColor = .kakaoYellow
            indexButton.alpha = 1
            indexButton.setTitle(String(orderOfSelectedImage!), for: .normal)
        } else{
            imageView.layer.borderColor = UIColor.clear.cgColor
            
            indexButton.layer.borderColor = UIColor.darkGray.cgColor
            indexButton.backgroundColor = .white
            indexButton.alpha = 0.7
            indexButton.setTitle("", for: .normal)
        }
    }
    
    //MARK: - Action Method
    
    @objc private func indexButtonTapped(){
        isSelectedImage.toggle()
        delegate?.cellStateChanged(indexPath: indexPath!, isSelectedImage)
    }
}