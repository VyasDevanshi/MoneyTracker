//  AddCCategoryViewController.swift
//  MoneyTracker
//  Created by Mac on 18/12/1944 Saka.

import UIKit
class AddCategoryViewController: UIViewController {
    var category:CCategory?
    
    @IBOutlet weak var categoryTxt: UITextField!
    let datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addToSubCategory(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddSubCategoryViewController") as! AddSubCategoryViewController
        vc.hidesBottomBarWhenPushed = true
        DispatchQueue.main.async{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func saveCategory(_ sender: Any) {
        let Cat = categoryTxt.text
        
       
        if Cat!.isEmpty{
                let alert = UIAlertController(title:"Alert" , message:"Please Enter Valid Category Name", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"OK", style: .default , handler: nil))
                present(alert, animated: true , completion: {
                    return})
            }
            else{
                DBManager.createCategory( name:categoryTxt.text!, pid : 0) {
                    DispatchQueue.main.async{
                        self.navigationController?.popViewController(animated: true)
                    }
                }
        }
    }
}
   
    
extension AddCategoryViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        true
    }
}










// DBManager.updateCategories(employee: employee)
//  self.navigationController?.popViewController(animated: true)

// DBManager.createCCategory(cid: categoryTxt.text!.trimmed(), pid:))

//     func updateUI() {
//
//        if let cat =  category {
//            categoryTxt.text = cat.name
//
//         //    txtName.text = employee.name
//         //   txtSurname.text = employee.surname
//       }
//     }


//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//        if let sender = sender as? Employee {
//            let vc = segue.destination as! AddEmployeeVC
//            vc.currentEmployee = sender
//        }
//    }





//    func showDatePicker(){

//        //Formate Date
//        datePicker.datePickerMode = .date
//        datePicker.maximumDate = Date()
//        //ToolBar
//        let toolbar = UIToolbar();
//        toolbar.sizeToFit()
//        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
//
//        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
//
//        txtBirthDate.inputAccessoryView = toolbar
//        txtBirthDate.inputView = datePicker

// }

//    @objc func donedatePicker(){
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd/MM/yyyy"
//        txtBirthDate.text = formatter.string(from: datePicker.date)
//        self.view.endEditing(true)
//    }

//    @objc func cancelDatePicker(){
//        self.view.endEditing(true)
//    }
