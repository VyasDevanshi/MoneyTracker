//
//  SubCCategoryViewController.swift
//  MoneyTracker
//
//  Created by TechExtensor PVT LTD on 23/03/23.
//

import UIKit

class SubCategoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var subcategories:[CCategory] = []
    var selectedCategory = CCategory()
    var identifier = "SubCategoryTableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        
        let header = UIView(frame: CGRect(x:0, y:0, width: view.frame.size.width, height:30))
        tableView.tableHeaderView = header
        let label = UILabel(frame: header.bounds)
        label.text = "Sub Categories"
        label.textAlignment = .center
        header.addSubview(label)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        subcategories = DBManager.getAllSubCategories(cid: selectedCategory.cid)

        tableView.reloadData()
    }
}

extension SubCategoryViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        subcategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! SubCategoryTableViewCell
        let subcat = self.subcategories[indexPath.row]
        cell.subCategoryLbl.text = subcat.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return .delete
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let alertController = UIAlertController(title: "Alert" , message: "Are You Sure You Want To Delete Sub Category", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                tableView.beginUpdates()
                
                let cat = self.subcategories.remove(at: indexPath.row)
                
                DBManager.deleteSubCategory(category: cat)
                
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
