//
//  AddSubCCategoryViewController.swift
//  MoneyTracker
//
//  Created by Mac on 18/12/1944 Saka.
//

import UIKit

class AddSubCategoryViewController: UIViewController {

    @IBOutlet weak var categoryTxt: UITextField!
    
    @IBOutlet weak var subCategoryTxt: UITextField!
    
    var categoryList = [CCategory]()
    var catid:CCategory = CCategory()
    let datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()

    
    @IBOutlet weak var categoryPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTxt.inputView = categoryPickerView
        categoryPickerView.isHidden = true
        
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
        categoryTxt.delegate = self
        
        categoryList = DBManager.getAllCategories()
    }
    
    @IBAction func saveSubCategory(_ sender: Any) {
        let SubCat = subCategoryTxt.text
        let Cat = categoryTxt.text
        if SubCat?.isEmpty == false || Cat?.isEmpty == false{
//            if SubCat?.isValidCategoryAndSubCategory() == false {
//                let alert = UIAlertController(title:"Alert" , message:"Please Enter Valid SubCategory Name", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title:"OK", style: .default , handler: nil))
//                present(alert, animated: true , completion: {
//                return})
//            }
//
          //  else{
                DBManager.createCategory(name:subCategoryTxt.text!, pid : catid.cid){
                DispatchQueue.main.async{
                    self.navigationController?.popViewController(animated: true)
              //  }
            }
        }
      }
      else{
          let alert = UIAlertController(title:"Alert" , message:"Do Not Empty Any Fields", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title:"OK", style: .default , handler: nil))
          present(alert, animated: true , completion: {
              return})
      }
    }
}
    
extension AddSubCategoryViewController:UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return categoryList.count
    }
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryTxt.text = categoryList[row].name
        catid = categoryList[row]
        categoryPickerView.isHidden = true
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        categoryList[row].name
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        categoryPickerView.isHidden = false
        return false
       }
}
