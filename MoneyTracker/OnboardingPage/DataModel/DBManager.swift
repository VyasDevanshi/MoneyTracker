//
//  DBManager.swift
//  MoneyTracker
//
//  Created by TechExtensor PVT LTD on 17/03/23.
//

import Foundation
import CoreData

let DBManager = DatabaseManager.shared

class DatabaseManager {
    static var shared = DatabaseManager()
    
    // MARK: - Core Data stack
    init() {
        persistentContainer.loadPersistentStores { obj, err in
            if let err = err {
                print(err.localizedDescription)
            }
            print("DBPATH:",obj.accessibilityPath)
        }
    }
    var context:NSManagedObjectContext!
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "MoneyTracker")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        context = container.viewContext
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //User Table Operations
    func createUser(country:String,emailid:String,name:String,password:String,completed:@escaping()->()){
        persistentContainer.performBackgroundTask { context in
            let users = User(context: self.context)
            users.name = name
            users.emailid = emailid
            users.password = password
            users.country = country
            try! self.context.save()
            completed()
        }
    }
    
    func getAllUsers() ->[User]{
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        do{
            let array = try self.context.fetch(fetchRequest) as [User]
            return array
        } catch{
            return []
        }
    }
    
    
    //Category Table Operations
    func createCategory(name:String, pid:Int16, completed:@escaping()->()){
        persistentContainer.performBackgroundTask{ context in
            let allCategories = self.getAllCategories()
            let category = CCategory(context: self.context)
            category.cid = allCategories.count > 0 ? allCategories.last!.cid + 1 : 1
            category.name = name
            category.pid = pid
            try! self.context.save()
            completed()
        }
    }
    
    func getCategoryId(id:Int16) -> CCategory? {
        let fetchRequest: NSFetchRequest<CCategory> = CCategory.fetchRequest()
       
        
        let pred =  NSPredicate(format: "cid == \(id)")
        fetchRequest.predicate = pred
        
        do{
            var cat = try context.fetch(fetchRequest)
            return cat.first!
        }
        
        catch{
           return nil
        }
        
    }
    
    func getAllCategories() -> [CCategory] {
        let fetchRequest: NSFetchRequest<CCategory> = CCategory.fetchRequest()
        let pred =  NSPredicate(format: "pid CONTAINS 0")
        fetchRequest.predicate = pred
        do {
            let array = try self.context.fetch(fetchRequest) as [CCategory]
            return array
        } catch {
            return []
        }
    }
    
    func getAllSubCategories(cid:Int16) -> [CCategory] {
        let fetchRequest: NSFetchRequest<CCategory> = CCategory.fetchRequest()
        let pred =  NSPredicate(format: "pid == \(cid)")
        fetchRequest.predicate = pred
        do {
            let array = try self.context.fetch(fetchRequest) as [CCategory]
            return array
        } catch {
            return []
        }
    }
    
    func deleteCategory(category:CCategory,cid:Int16, isBatch:Bool = false) {
        let fetchRequest: NSFetchRequest<CCategory> = CCategory.fetchRequest()
        let pred =  NSPredicate(format: "cid == \(category.cid) OR pid == \(category.cid )")
        fetchRequest.predicate = pred
        do {
            let array = try self.context.fetch(fetchRequest) as [CCategory]
            for data in array{
                context.delete(data)
            }
        } catch{}
        if !isBatch {
            try! context.save()
        }
    }
    
    func deleteSubCategory(category:CCategory,isBatch:Bool = false){
        context.delete(category)
        if !isBatch {
            try! context.save()
        }
    }
    
//    func updateCategory(category:CCategory) {
//        try! context.save()
//    }
    
    //Transaction Table Operations
    func createTransaction(account:String, amount:Double, date:Date, note:String, type:Bool ,category:CCategory?, completed:@escaping()->()){
        persistentContainer.performBackgroundTask{ context in
            let allTransactions = self.getAllTransactions()
            let transaction = Transaction(context: self.context)
            transaction.tid = allTransactions.count > 0 ? allTransactions.last!.tid + 1 : 1
            transaction.type = type
            transaction.category = category // category != nil ? cat : nil
            transaction.account = account
            transaction.amount = amount
            transaction.date = date
            transaction.note = note
            try! self.context.save()
            completed()
        }
    }
    
    func updateTransaction(account:String,amount:Double, date:Date, note:String,category:CCategory?,transaction:Transaction){
        let fetchRequest: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        let pred =  NSPredicate(format: "tid == \(transaction.tid)")
        fetchRequest.predicate = pred
        do{
            let tran = try context.fetch(fetchRequest)
            tran.first!.date = date
            tran.first!.amount = amount
            tran.first!.account = account
            tran.first!.category = category
            tran.first!.tid = transaction.tid
            tran.first!.note = note
            tran.first!.type = transaction.type
            try! self.context.save()
        
        }
        catch {

        }
   }
    
    func getAllTransactions() -> [Transaction]{
        let fetchRequest: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        do {
            let array = try self.context.fetch(fetchRequest) as [Transaction]
            return array
        } catch {
            return []
        }
    }
    
    func filterTransactions(startDate:Date,endDate:Date) -> [Transaction] {

        let fetchRequest: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        
        let dff = DateFormatter()
        dff.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dff.timeZone = TimeZone(identifier: "UTC")
        
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        
        let pred:NSPredicate
       // let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: startDate)
        let endOfDay = calendar.startOfDay(for: calendar.date(byAdding: .day, value: 1, to: endDate)!)
          pred =  NSPredicate(format: "(date >= %@) AND (date < %@)", startOfDay as NSDate, endOfDay as NSDate)
        fetchRequest.predicate = pred
        
        do {
            let array = try self.context.fetch(fetchRequest) as [Transaction]
            return array
        } catch {
            return []
        }
    }
    
    func deleteTransaction(transaction:Transaction,isBatch:Bool = false) {
        context.delete(transaction)
        if !isBatch {
            try! context.save()
        }
    }
    
    //Note Table Operations
    func createNote(date:Date,title:String,content:String,completed:@escaping()->()){
            persistentContainer.performBackgroundTask{ context in
                let note = Notes(context: self.context)
                note.date = date
                note.title = title
                note.content = content
                try! self.context.save()
                completed()
        }
    }
    
    func updateNotes(date:Date,title:String,content:String,notes:Notes){
        let fetchRequest: NSFetchRequest<Notes> = Notes.fetchRequest()

        do{
            let note = try context.existingObject(with: notes.objectID) as! Notes
            note.content = content
            note.title = title
            note.date = date
            try! self.context.save()
        }
        catch{
        }
    }
    
    func getAllNotes() ->[Notes]{
        let fetchRequest: NSFetchRequest<Notes> = Notes.fetchRequest()
        do{
            let array = try self.context.fetch(fetchRequest) as [Notes]
            return array
        } catch{
            return []
        }
    }
    
    func deleteNotes(notes:Notes,isBatch:Bool = false) {
        context.delete(notes)
        if !isBatch {
            try! context.save()
        }
    }
}
    



//    func deleteAll() {
//        let fetchRequest: NSFetchRequest<Category> = Employee.fetchRequest()
//
//        do {
//            let array = try self.context.fetch(fetchRequest) as [Employee]
//            for employee in array {
//                deleteEmployee(employee: employee, isBatch: true)
//            }
//            try! context.save()
//        } catch {
//        }
//    }
