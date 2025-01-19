//
//  OnBoardingViewController.swift
//  MoneyTracker
//
//  Created by Mac on 15/12/1944 Saka.
//

import UIKit
class OnBoardingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageController: UIPageControl!
    
    @IBOutlet weak var getStartBtn: UIButton!
    
    var slides:[OnboardingPageList] = []
    var currentPage = 0{
        didSet{
            pageController.currentPage = currentPage
            if currentPage == slides.count - 1{
                getStartBtn.setTitle("Get Started", for: .normal)
            }
            else{
                getStartBtn.setTitle("Next", for: .normal)
            }
        }
    }
    override func viewDidLoad() {
     
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        slides = [OnboardingPageList(title: "Easy To Manage Your Money", subTitle: "All your spends,bills,credit card and E-wallet money all at one place", images: UIImage(named: "img1")!),
                  OnboardingPageList(title: "Analystic Report Generate", subTitle: "Analyse Your All Money Week,Month and Year Wise", images: UIImage(named: "img2")!),
                  OnboardingPageList(title: "Track Your Money", subTitle: "Track Your all Expenses and Incomes", images: UIImage(named: "img3")!),
        
        ]
//        slides = [OnboardingPageList(title:"Track Your Expense",subTitle:"All your spends,bills,credit card and E-wallet money all at one place", images:),
//                  OnboardingPageList(title:"Track Your Expense",subTitle:"All your spends,bills,credit card and E-wallet money all at one place", images: "img2"),
//                  OnboardingPageList(title:"Track Your Expense",subTitle:"All your spends,bills,credit card and E-wallet money all at one place", images: "img3")]
    }
    
    @IBAction func OnClickGetStart(_ sender: Any){
        if currentPage == slides.count - 1
        {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)

        }
        
    }
}

extension OnBoardingViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OnBoardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}

