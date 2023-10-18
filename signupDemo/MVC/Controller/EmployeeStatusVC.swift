import UIKit
import CoreData

class EmployeeStatusVC: UIViewController {
// MARK: Variables----------------------->
    var nameArray = ["Naveen","Manoj","Dev","Jai","Ram"]
    var designationArray = ["iOS","Android","Java","Flutter","React"]
    var ExperienceArray = ["1 Years","5 Years","7 Years","10 Years","10+ Years"]
    
    
    @IBOutlet weak var dataTableView: UITableView!
    var employeeEntity: [EmployeeEntity] = []
    let manager = DatabaseManager()
    var context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
// MARK: Reload and fetch data in tableView----------------------->
    override func viewWillAppear(_ animated: Bool) {
        employeeEntity = manager.fetchUser()
        dataTableView.reloadData()
    }
    
// MARK: SignOut button with alert action(Navigation to login page)----------------------->
    @IBAction func signOutBarBtn(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Confirm!", message: "Are you sure want to logout?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .default))
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (_) in
            self.navigationController?.popToRootViewController(animated: true)
            print("User logged out")
        }))
        present(alert, animated: true)
    }
    
// MARK: Navigation to EmployeeProfileVC (add button to add employee data)----------------------->
    @IBAction func addBarBtn(_ sender: UIBarButtonItem) {
       addUpdateEmployeeNavigation()
    }
    
    func addUpdateEmployeeNavigation(user: EmployeeEntity? = nil ) {
        let profileStr = UIStoryboard(name: "Main", bundle: nil)
        let profileVC = profileStr.instantiateViewController(withIdentifier: "EmployeeProfileVC") as! EmployeeProfileVC
//        profileVC.user = user!
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
}

extension EmployeeStatusVC : UITableViewDelegate, UITableViewDataSource {
    
    // MARK:  Employee data tableView----------------------->
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeEntity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dataTableView.dequeueReusableCell(withIdentifier: "dataCell") as! DataTableViewCell
        
        // MARK: Fetch data in tableView labels----------------------->
        let employee = employeeEntity[indexPath.row]
        cell.lblName.text = employee.name
        cell.lblDesignation.text = (employee.designation ?? "") + " " + "Developer"
        cell.lblExperience.text = (employee.experience ?? "") + " " + "Years"
//        cell.employee = employee
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //        let update = UIContextualAction(style: .normal, title: "Update", handler: {_,_,_ in
        //            self.addUpdateEmployeeNavigation(user: self.employeeEntity[indexPath.row])
        //        })
        //        update.backgroundColor = .darkGray
        let delete = UIContextualAction(style: .destructive, title: "Delete", handler: { _, _, _ in
            self.employeeEntity.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            // MARK: Update deleted data again----------<<<<
            
            self.dataTableView.reloadData()
        })
    
        //        let deleteAction = UIContextualAction(style: .destructive, title: nil) { _, _, complete in
        //            // Remove the note from the CoreData
        //            AppDelegate.sharedAppDelegate.coreDataStack.managedContext.delete(self.notes[indexPath.row])
        
        //            self.notes.remove(at: indexPath.row)
        //            // Save Changes
        //            AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
        //            // Remove row from TableView
        //            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        //            complete(true)
        //        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
        if editingStyle == .delete {
            
        }
    }
}
    


extension EmployeeStatusVC {

// MARK: Toast message function---------------------->
    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: 0, y: self.view.frame.size.height-100, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.systemBackground
        toastLabel.font = font
        toastLabel.center = self.view.center //Center in UI(Replace it to correct Y axis)
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds  =  true	
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.2, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.5
        }, completion: {(isCompleted) in toastLabel.removeFromSuperview()
        })
    }
}
