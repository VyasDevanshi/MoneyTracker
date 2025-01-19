//  CCategoryViewController.swift
//  MoneyTracker
//  Created by Mac on 18/12/1944 Saka.

import UIKit
class DisplayCategoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var categories:[CCategory] = []
    var catid:CCategory = CCategory()
    var identifier = "DisplayCategoryTableViewCell"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22),NSAttributedString.Key.foregroundColor: UIColor.white]
        categories = DBManager.getAllCategories()
        tableView.reloadData()
    }
    
    @IBAction func addCategory(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddCategoryViewController") as! AddCategoryViewController
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension DisplayCategoryViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! DisplayCategoryTableViewCell
        let cat = self.categories[indexPath.row]
        cell.catNameLbl?.text = cat.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SubCategoryViewController") as! SubCategoryViewController
        vc.selectedCategory = self.categories[indexPath.row]
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alertController = UIAlertController(title: "Alert" , message: "Are You Sure You Want To Delete Category And Also SubCategories of Perticular Category", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            tableView.beginUpdates()
            let cat = self.categories.remove(at: indexPath.row)
            DBManager.deleteCategory(category: cat, cid: cat.cid)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
            
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
                alertController.dismiss(animated: true)
        }
            
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true)
        }
    }
}
