
//  HomeViewController.swift
//  MoneyTracker
//  Created by Mac on 18/12/1944 Saka.

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var segmentHome: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var dateTxt: UITextField!
    
    var transactions:[Transaction] = []
    var mainArray:[DashBoardData] = []
    var ftransaction:Transaction!
    var identifier1 = "HomeTableViewCell"
    var identifier2 = "TableViewCell"
    let datePicker = UIDatePicker()
    let dateFormatter = DateFormatter() // for label date
    let dateFormatter2 = DateFormatter() //for header of data date
    let newdf = DateFormatter()
    var dateComponents = DateComponents()
    let calendar = Calendar.current
    var startDate = Date()
    var endDate = Date()
    var selectedDate = Date()
    
    override func viewWillAppear(_ animated: Bool) {
//        let initialDate = Date()
//        datePicker.date = initialDate
        weekPeriod(date:selectedDate)
        print("Start of week: \(startDate)")
        print("End of week: \(endDate)")
        dataShow()
        // transactions = DBManager.getAllTransactions()
//        transactions = DBManager.filterTransactions(startDate: startDate, endDate: endDate)
//        tableView.reloadData()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22),NSAttributedString.Key.foregroundColor: UIColor.white]
        dateFormatter.dateFormat = "dd/MM/YYYY"
//        mainArray.removeAll()
//        dataShow()
//        tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        tableView.delegate = self
        tableView.dataSource = self
        dateFormatter.dateFormat = "dd/MM/YYYY"
        self.tableView.register(UINib(nibName: identifier1, bundle: nil), forCellReuseIdentifier: identifier1)
        self.tableView.register(UINib(nibName: identifier2, bundle: nil), forHeaderFooterViewReuseIdentifier: identifier2)
        segmentHome.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)], for: UIControl.State.selected)
        segmentHome.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], for: .normal)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        dateTxt.borderStyle = .none
        showDate()
        
    }
    
    func dataShow(){
        transactions = DBManager.filterTransactions(startDate: startDate, endDate: endDate)
        transactions.sort(by: { $0.date! < $1.date! })
        mainArray.removeAll()
        let df = DateFormatter()
        
        df.dateFormat = "dd/MM/YYYY"
        for t in transactions{
            var isFound = false
            
            for j in mainArray {
                if df.string(from: j.date!) == df.string(from: t.date!) {
                    j.arrayItem.append(t)
                    isFound = true
                }
            }
            
            if  !isFound {
                let newobj = DashBoardData()
                newobj.date = t.date
                newobj.arrayItem.append(t)
                mainArray.append(newobj)
            }
        }
        tableView.reloadData()
    }
    
    func showDate() {
        
        // Set the date picker mode to date
        datePicker.datePickerMode = .date
        segmentHome.addTarget(self, action: #selector(changeSegmentView(_:)), for: .valueChanged)
        
//      let initialDate = Date()
//      datePicker.date = initialDate
//      let startingDate = datePicker.date
        
        dateTxt.text = dateFormatter.string(from: datePicker.date)
        
        // Set date picker as input view for text field
        dateTxt.inputView = datePicker
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        } else {
            
        }
        
        // Add a toolbar with a Done button to dismiss the date picker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissPicker))
        toolbar.items = [doneButton]
        dateTxt.inputAccessoryView = toolbar
        dateTxt.text = dateFormatter.string(from: selectedDate)
    }
    
    func weekPeriod(date:Date) -> () {
        
        if segmentHome.selectedSegmentIndex == 0 {
            startDate = selectedDate
            endDate = selectedDate
        }
        
        else if segmentHome.selectedSegmentIndex == 1 {
             startDate = date.startOfWeek!
             endDate = date.endOfWeek!
        }
        
        else if segmentHome.selectedSegmentIndex == 2 {
            startDate = date.startDateOfMonth!
            endDate = date.endDateOfMonth!
        }
        
        else if segmentHome.selectedSegmentIndex == 3 {
            startDate = date.startDateOfYear!
            endDate = date.enddateOfYear!
        }
        
        dataShow()
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        
        selectedDate = sender.date
        dateTxt.text = dateFormatter.string(from: selectedDate)
        weekPeriod(date:selectedDate)
        dataShow()
        
//      tableView.reloadData()
        
    }

    @objc func dismissPicker() {
        view.endEditing(true)
        dateTxt.text = dateFormatter.string(from: datePicker.date)
        dateTxt.text = dateFormatter.string(from: selectedDate)
    }
 
    @IBAction func addIncomeExpense(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddINcomeExpenceViewController") as! AddINcomeExpenceViewController
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func changeSegmentView(_ sender: UISegmentedControl) {
        weekPeriod(date: selectedDate)
            if sender.selectedSegmentIndex == 0 {
                dateFormatter.dateFormat = "dd/MM/YYYY"
            }
            else if sender.selectedSegmentIndex == 1 {
                dateFormatter.dateFormat = "W'\u{02DA}Week"
            }
            else if sender.selectedSegmentIndex == 2 {
                dateFormatter.dateFormat = "MM YYYY"
            }
            else if sender.selectedSegmentIndex == 3 {
                dateFormatter.dateFormat = "YYYY"
            }
            let selectedDate = datePicker.date
            dateTxt.text = dateFormatter.string(from: selectedDate)
            dataShow()
   }
}

extension HomeViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if !mainArray.isEmpty{
            return mainArray.count
        }
        
        else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if mainArray[section].date == nil {
            return 0
        }
        else{
            return mainArray[section].arrayItem.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddINcomeExpenceViewController") as! AddINcomeExpenceViewController
        vc.selectedTransaction = mainArray[indexPath.section].arrayItem[indexPath.row]
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let tid = mainArray[section]
        dateFormatter2.dateFormat = "dd/MM/YYYY ccc HH:MM a"//header date set
        if self.mainArray[section].arrayItem.isEmpty {
            return nil
       }
        
       else{
            return dateFormatter2.string(from: (tid.date!))
        }
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tid = mainArray[indexPath.section].arrayItem[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier1) as! HomeTableViewCell
            cell.lblType.text = tid.type ? "Income" : "Expense"
            cell.lblCategory.text = tid.category?.name ?? ""
            cell.lblAmount.text = "\(tid.amount)"
            cell.lblAccount.text = tid.account
            cell.lblNote.text = tid.note
            return cell
        
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let alertController = UIAlertController(title: "Alert" , message: "Are You Sure You Want To Delete Transaction", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                
                tableView.beginUpdates()
                let transactionid = self.mainArray[indexPath.section].arrayItem.remove(at: indexPath.row)
                DBManager.deleteTransaction(transaction: transactionid)
                tableView.deleteRows(at: [indexPath], with: .fade)
               
                if self.mainArray[indexPath.section].arrayItem.isEmpty{
                    self.mainArray.remove(at: indexPath.section)
                    tableView.deleteSections([indexPath.section], with: .automatic)
                }
                tableView.endUpdates()
                tableView.reloadData()
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
                alertController.dismiss(animated: true)
            }
            
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension Date {
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }
    
    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 7, to: sunday)
    }
    
    var startDateOfMonth: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let dates = gregorian.date(from: gregorian.dateComponents([.year,.month], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: dates)!
    }
    
    var endDateOfMonth: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        let dates = DateComponents(month: 1, day: -1)
        return gregorian.date(byAdding: dates , to: startDateOfMonth!)!
    }

    var startDateOfYear: Date?{
        let gregorian = Calendar(identifier: .gregorian)
        guard let dates = gregorian.date(from: gregorian.dateComponents([.year], from: self))else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: dates)
    }
     
    var enddateOfYear: Date?{
        let gregorian = Calendar(identifier: .gregorian)
        guard let dates = gregorian.date(from: gregorian.dateComponents([.year], from: self)) else { return nil }
        return gregorian.date(byAdding: .year, value:1, to: dates)
    }
}
