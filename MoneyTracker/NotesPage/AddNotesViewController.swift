//  AddNotesViewController.swift
//  MoneyTracker
//  Created by Mac on 18/12/1944 Saka.

import UIKit
class AddNotesViewController: UIViewController {

    @IBOutlet weak var contentText: UITextView!

    @IBOutlet weak var dateText: UITextField!

    @IBOutlet weak var titleText: UITextField!
    
    var noteList = [Notes]()
    var notid:Notes = Notes()
    var selectedNote:Notes!
    let datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()
        contentText.text = "Content of notes"
        contentText.textColor = UIColor.lightGray
        contentText.layer.borderWidth = 1
        contentText.layer.borderColor = UIColor.lightGray.cgColor
        contentText.layer.cornerRadius = 10
       // noteList = DBManager.getAllNotes()
        showDate()
        
    }
    
    override func viewWillAppear(_ animated: Bool){
        if selectedNote != nil{
            dateFormatter.dateFormat = "dd/MM/YYYY"
            dateText.text = dateFormatter.string(from: selectedNote.date!)
            contentText.text = selectedNote.content
            titleText.text = selectedNote.title
            
        }
    }
    
    func showDate()
    {
        datePicker.datePickerMode = .date
        dateFormatter.dateFormat = "dd/MM/YYYY"
        
        //segmentHome.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        let initialDate = Date()
        datePicker.date = initialDate
        //Set date picker as input view for text field
        dateText.inputView = datePicker
        //Add a toolbar with a Done button to dismiss the date picker
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissPicker))
        toolbar.items = [doneButton]
        
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        }
        
        else {
        }
        
        dateText.inputAccessoryView = toolbar
        let selectedDate = datePicker.date
        dateText.text = dateFormatter.string(from: selectedDate)
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        dateText.text = dateFormatter.string(from: selectedDate)
    }
    
    @objc func dismissPicker() {
        view.endEditing(true)
    }
    
    @IBAction func saveNotes(_ sender: Any) {
        let Content = contentText.text
        let Title = titleText.text
        
            if Title?.isEmpty == false {
                if selectedNote == nil{
                    DBManager.createNote(date: datePicker.date, title: titleText.text!, content: contentText.text!){
                        DispatchQueue.main.async{
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
                else{
                    DBManager.updateNotes(date: datePicker.date, title: titleText.text!, content: contentText.text!, notes: selectedNote)
                    DispatchQueue.main.async{
                        self.navigationController?.popViewController(animated: true)
                    }
                }
           }
            else{
                let alert = UIAlertController(title:"Alert" , message:"Do Not Empty Title Field", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"OK", style: .default , handler: nil))
                present(alert, animated: true , completion: {
                    return})
            }
    }
}

extension AddNotesViewController :UITextViewDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
}
