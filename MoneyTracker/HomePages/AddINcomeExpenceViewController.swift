//  AddINcomeExpenceViewController.swift
//  MoneyTracker
//  Created by Mac on 18/12/1944 Saka.

import UIKit

class AddINcomeExpenceViewController: UIViewController {
    
    @IBOutlet weak var addIncomeExpenseSegment: UISegmentedControl!
    
    @IBOutlet weak var dateSelected: UITextField!
    
    @IBOutlet weak var amount: UITextField!
    
    @IBOutlet weak var categorySelected: UITextField!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    
    @IBOutlet weak var categoryHeight: NSLayoutConstraint!
    @IBOutlet weak var catBottom: NSLayoutConstraint!
    @IBOutlet weak var subCatHeight: NSLayoutConstraint!
    @IBOutlet weak var subCatBottom: NSLayoutConstraint!
    
    @IBOutlet weak var accountSelected: UITextField!
    @IBOutlet weak var accountPickerView: UIPickerView!
    
    @IBOutlet weak var notes: UITextField!
    
    @IBOutlet weak var segmentViewController: UISegmentedControl!
    
    @IBOutlet weak var subCategorySelected: UITextField!
    
    @IBOutlet weak var subCategoryPickerView: UIPickerView!
    
    
    var accountList:[String] = ["Saving Account","Salary Account"]
    var categoryList = [CCategory]()
    var subCategoryList = [CCategory]()

    var selectedCategory = CCategory()
    var catid:CCategory = CCategory()
    
    let datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
    let newdf = DateFormatter()
    let textField = UITextField()
    var selectedTransaction:Transaction!
    var getcategory = CCategory()

    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),NSAttributedString.Key.foregroundColor: UIColor.white]
        
        categoryList = DBManager.getAllCategories()
        
           if selectedTransaction != nil {
               if selectedTransaction.type == true {
                   segmentViewController.selectedSegmentIndex = 0
                   
                   dateFormatter.dateFormat = "dd/MM/YYYY ccc HH:MM a"
                   dateSelected.text = dateFormatter.string(from: selectedTransaction.date!)
                   
                   amount.text = "\(selectedTransaction.amount)"
                   accountSelected.text = selectedTransaction.account
                   notes.text = selectedTransaction.note
               }
         
            else{
                 categorySelected.isHidden = false
                 categoryHeight.constant = 30
                 subCatBottom.constant = 20
                 segmentViewController.selectedSegmentIndex = 1
                 dateFormatter.dateFormat = "dd/MM/YYYY ccc HH:MM a"
                 dateSelected.text = dateFormatter.string(from: selectedTransaction.date!)
                 
                 amount.text = "\(selectedTransaction.amount)"
                 accountSelected.text = selectedTransaction.account
                 notes.text = selectedTransaction.note
                
                 if selectedTransaction.category?.pid == 0{
                     categorySelected.text = selectedTransaction.category?.name
                 }

                 else{
                     subCategorySelected.isHidden = false
                     subCatHeight.constant = 30
                     catBottom.constant = 20
                     getcategory = DBManager.getCategoryId(id:selectedTransaction.category!.pid )!
                     // catid = selectedTransaction.category?.cid
                     categorySelected.text = getcategory.name
                     subCategorySelected.text = selectedTransaction.category?.name
                }
            }
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if selectedTransaction == nil{
            addIncomeExpenseSegment.isUserInteractionEnabled = true
            addIncomeExpenseSegment.isEnabled = true
        }
        else{
            addIncomeExpenseSegment.isEnabled = false
            addIncomeExpenseSegment.isUserInteractionEnabled = false
        }
        addIncomeExpenseSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)], for: UIControl.State.selected)
        
        addIncomeExpenseSegment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white,NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], for: .normal)
        
        
        categorySelected.inputView = categoryPickerView
        accountSelected.inputView = accountPickerView
        subCategorySelected.inputView = subCategoryPickerView
        
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
        
        accountPickerView.delegate = self
        accountPickerView.dataSource = self
        
        subCategoryPickerView.delegate = self
        subCategoryPickerView.dataSource = self
        
        categorySelected.delegate = self
        accountSelected.delegate = self
        subCategorySelected.delegate = self
        
        categoryPickerView.isHidden = true
        accountPickerView.isHidden = true
        subCategoryPickerView.isHidden = true
        
        categorySelected.isHidden = true
        subCategorySelected.isHidden = true
        
        categoryPickerView.layer.cornerRadius = 10
        subCategoryPickerView.layer.cornerRadius = 10
        showDate()
    }
    
    func showDate(){
        datePicker.datePickerMode = .dateAndTime
        dateFormatter.dateFormat = "dd/MM/YYYY EEE HH:MM a"
//        let initialDate = Date()
//
//       datePicker.date = initialDate
        
        // Set date picker as input view for text field
        dateSelected.inputView = datePicker
        
        // Add a toolbar with a Done button to dismiss the date picker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissPicker))
        toolbar.items = [doneButton]
        
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        } else {
        }
        
        dateSelected.inputAccessoryView = toolbar
        let selectedDate = datePicker.date
        dateSelected.text = dateFormatter.string(from: selectedDate)
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        dateSelected.text = dateFormatter.string(from: selectedDate)
    }
    
    @objc func dismissPicker() {
        view.endEditing(true)
    }
    
    
    @IBAction func changeSegmentController(_ sender: UISegmentedControl) {
      
        if selectedTransaction == nil{
            if sender.selectedSegmentIndex == 1 {
                categorySelected.isHidden = false
                categoryHeight.constant = 30
                subCatBottom.constant = 20
            }
            
            else if sender.selectedSegmentIndex == 0 {
                subCategorySelected.isHidden = true
                categorySelected.isHidden = true
                categoryHeight.constant = 0
                subCatHeight.constant = 0
                catBottom.constant = 0
                subCatBottom.constant = 0
            }
        }
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        let Amount = amount.text
//        let Date = dateSelected.text
        let Account = accountSelected.text
//        let Category = categorySelected.text
        let Note = notes.text
        
        if !Amount!.isEmpty || !Account!.isEmpty || !Note!.isEmpty {
            if !Amount!.isValidAmount() {
                
                let alert = UIAlertController(title:"Alert" , message:"Please Enter Valid Amount", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"OK", style: .default , handler: nil))
                present(alert, animated: true , completion: {
                    return
                })
                
            }else if Account!.isEmpty {
                let alert = UIAlertController(title:"Alert" , message:"Please fill Account name", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"OK", style: .default , handler: nil))
                present(alert, animated: true , completion: {
                    return
                })
            }else if Note!.isEmpty {
                let alert = UIAlertController(title:"Alert" , message:"Please fill Notes", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"OK", style: .default , handler: nil))
                present(alert, animated: true , completion: {
                    return
                })
            }else if categorySelected.text!.isEmpty && segmentViewController.selectedSegmentIndex == 1{
                let alert = UIAlertController(title:"Alert" , message:"Please fill Category", preferredStyle: .alert)
                                            alert.addAction(UIAlertAction(title:"OK", style: .default , handler: nil))
                                            present(alert, animated: true , completion: {
                                                return
                                            })
            }
            
            else{
                
                if selectedTransaction == nil {
                    if segmentViewController.selectedSegmentIndex == 0 {
                        DBManager.createTransaction(account: accountSelected.text! , amount: Double(amount.text ?? "0")!, date: datePicker.date , note: notes.text! , type:true, category:nil) {
                            DispatchQueue.main.async{
                                self.navigationController?.popViewController(animated: true)
                                
                            }
                        }
                    }
                    
                    else if segmentViewController.selectedSegmentIndex == 1{
                        DBManager.createTransaction(account: accountSelected.text! , amount: Double(amount.text!)!, date: datePicker.date , note: notes.text!, type:false,category: catid){
                            DispatchQueue.main.async{
                                self.navigationController?.popViewController(animated: true)
                            }
                        }
                    }
                }
                else {
                    
                    if segmentViewController.selectedSegmentIndex == 0 {
                        DBManager.updateTransaction(account: accountSelected.text!, amount: Double(amount.text ?? "0")!, date: datePicker.date , note: notes.text!, category: nil,transaction: selectedTransaction)
                        DispatchQueue.main.async {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
    
                    else if segmentViewController.selectedSegmentIndex == 1 {
                        DBManager.updateTransaction(account: accountSelected.text!, amount: Double(amount.text ?? "0")!, date: datePicker.date , note: notes.text!, category: catid,transaction: selectedTransaction)
                        DispatchQueue.main.async {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                   
                }
            }
        }
        else{
                let alert = UIAlertController(title:"Alert" , message:"Please Enter all fields", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"OK", style: .default , handler: nil))
                present(alert, animated: true , completion: {
                    return
                })
            }
    }
}

extension AddINcomeExpenceViewController:UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if pickerView == categoryPickerView {
            return categoryList.count
        }
        else if pickerView == accountPickerView{
            return accountList.count
        }
        else if pickerView == subCategoryPickerView{
                return subCategoryList.count
        }
      return 0
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == categoryPickerView {
            categorySelected.text = categoryList[row].name
            catid = categoryList[row]
            categoryPickerView.isHidden = true
            subCategoryList = DBManager.getAllSubCategories(cid: catid.cid)
            
            if !subCategoryList.isEmpty{
                subCategoryPickerView.reloadAllComponents()
                subCategorySelected.isHidden = false
                subCatHeight.constant = 30
                catBottom.constant = 20
            }
            
            if selectedCategory != nil {
                if subCategoryList.isEmpty{
                    subCategoryPickerView.isHidden = true
                    subCategorySelected.isHidden = true
                    
                    subCatHeight.constant = 0
                    catBottom.constant = 0
                }
            }
        }
        
        else if pickerView == accountPickerView {
            accountSelected.text = accountList[row]
            accountPickerView.isHidden = true
        }
        
        else if pickerView == subCategoryPickerView {
                subCategorySelected.text = subCategoryList[row].name
                catid = subCategoryList[row]
                subCategoryPickerView.isHidden = true
        }
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == categoryPickerView{
            return categoryList[row].name
        }
        else if pickerView == accountPickerView{
            return accountList[row]
        }
        else if pickerView == subCategoryPickerView{
                return subCategoryList[row].name
        }
        return nil
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == categorySelected {
                categoryPickerView.isHidden = false
        }
        
        else if textField == accountSelected{
            accountPickerView.isHidden = false
        }
        
        else if textField == subCategorySelected{
                subCategoryPickerView.isHidden = false
        }
        
        return false
        
    }
}
