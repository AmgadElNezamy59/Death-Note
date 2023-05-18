

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    var noteArr = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print (FileManager.default.urls(for: .documentDirectory,in: .userDomainMask))
        
        loadData()
        
      
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath) as! TableViewCell
        let item = noteArr[indexPath.row]
        cell.noteLbl.text = item.title
        cell.accessoryType = item.done  ? .checkmark : .none
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
       noteArr[indexPath.row].done = !noteArr[indexPath.row].done
        saveData()
        
        tableView.reloadData()
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        noteArr.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        saveData()

    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deletAction = UIContextualAction(style: .destructive, title: "") { (action,view, completionHndler)  in
            self.noteArr.remove(at: indexPath.row)
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
            completionHndler(true)
        }
        deletAction.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [deletAction])
    }
    
    
    
    
    @IBAction func addButtonPreesed(_ sender: UIBarButtonItem) {
        
        var textFiled = UITextField()
        let alert = UIAlertController(title: "Death Note 🪶", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "☠️  ☠️  ☠️", style:.default) { (action) in
            
            let newItem = Item(context: self.context)
            newItem.title = textFiled.text!
            newItem.done = false
            
            self.noteArr.append(newItem)
            self.saveData()
            self.tableView.reloadData()
        }
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Add To List "
            textFiled = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true)
        
    }
    
    
    @IBAction func EditButtonPressed(_ sender: UIBarButtonItem) {
        
        tableView.isEditing = !tableView.isEditing
    }
    
    
    
    
    func saveData(){
        
     
        do{
            try context.save()
        }catch{
            print("error saving context  \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    

    func loadData(){
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do{
            noteArr = try context.fetch(request)
        }catch{
            print("error fetching data from context  \(error)")
        }
    }
}

