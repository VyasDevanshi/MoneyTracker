//
//  OnBoardingCollectionViewCell.swift
//  MoneyTracker
//
//  Created by Mac on 15/12/1944 Saka.
//

import UIKit

class OnBoardingCollectionViewCell: UICollectionViewCell {
//    static let identifier = String(describing: OnBoardingCollectionViewCell.self)
  
    @IBOutlet weak var collectonViewCellImage: UIImageView!
    
    @IBOutlet weak var collectionViewCellSubTitle: UILabel!
    
    @IBOutlet weak var collectionViewCellTitle: UILabel!
    var selectedImage:String?
    func setup(_ slide: OnboardingPageList){
        collectionViewCellTitle.text = slide.title
        collectionViewCellSubTitle.text = slide.subTitle
        collectonViewCellImage.image = slide.images
    }
    
}
