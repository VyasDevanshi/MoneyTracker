//  NoteViewController.swift
//  MoneyTracker
//  Created by Mac on 18/12/1944 Saka.

import UIKit

class NoteViewController: UIViewController {
    var identifier = "NotesTableViewCell"
    var notes:[Notes] = []
  
    let dateFormatter = DateFormatter()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.tabBarController?.tabBar.isHidden = false
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22),NSAttributedString.Key.foregroundColor: UIColor.white]
        
        
        notes = DBManager.getAllNotes()
        tableView.reloadData()
        
    }

    @IBAction func addNotes(_ sender: Any) {
      //  self.tabBarController?.tabBar.isHidden = true
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddNotesViewController") as! AddNotesViewController
        
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension NoteViewController:UITableViewDelegate,UITableViewDataSource {

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //  return notes[section].count
       return notes.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddNotesViewController") as! AddNotesViewController
        vc.selectedNote = self.notes[indexPath.row]
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! NotesTableViewCell
        let nid = self.notes[indexPath.row]
        dateFormatter.dateFormat = "dd/MM/YYYY"
        cell.dateLbl.text = dateFormatter.string(from: nid.date!)
      //  cell.dateLbl.text = "\(nid.date!)"
        cell.titleLbl.text = nid.title
        cell.contentLbl.text = nid.content
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
            
            let alertController = UIAlertController(title: "Alert" , message: "Are You Sure You Want To Delete Note", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                tableView.beginUpdates()
                
                let noteid = self.notes.remove(at: indexPath.row)
                DBManager.deleteNotes(notes: noteid)
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

        
        
        
        
        
        
        
        
        
        //  DBManager.deleteNotes(notes: noteid)
        
            
//
//           let alert = UIAlertController(title:"Alert" , message:"Are You Sure You Want To Delete Note", preferredStyle: .alert)
//
//            self.present(alert, title : "OK" , animated: true,completion: {
//
//            })
//            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel ,completion: {
//
//            })
//
//            let cancelAction = UIAlertAction(title: "cancel", style: .cancel ,completion: {
//                print("This executes after cancel button is pressed ")
//            })
//            alert.addAction(cancelAction)
//
            
//                           alert.addAction(UIAlertAction(title:"OK", style: .default , handler: nil))
//                               present(alert, animated: true , completion: {
//                                 return
//                            })
//            alert.addAction(UIAlertAction(title:"cancel", style: .default , handler: nil))
//            present(alert, animated: true , completion: {
//                return
//            })
          // if(alertController.addAction)
          
      
      
