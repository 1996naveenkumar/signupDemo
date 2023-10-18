import UIKit
import CoreData

// MARK: Class for DatabaseManager----------------------->
class DatabaseManager {
    
        private var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }

// MARK: Save the data to CoreData----------------------->
    func addUser(_ user: UserModel) {
        let employeeEntity = EmployeeEntity(context: context)
        employeeEntity.name = user.name
        employeeEntity.designation = user.designation
        employeeEntity.experience = user.experience
        saveUser()
    }
    
// MARK: Save data to CoreData----------------------->
    func saveUser() {
        do {
            try context.save()
            print("User Data Saved")
//            StatusVC.showToast(message: "Your data has been saved!", font: .systemFont(ofSize: 12.0))
        } catch {
            print("User data saving error",error)
        }
// MARK: return needed? <<<<------------
    }

// MARK: Fetch data from CoreData----------------------->
    func fetchUser() -> [EmployeeEntity] {
        var users: [EmployeeEntity] = []
        do{
            users = try context.fetch(EmployeeEntity.fetchRequest())
        } catch {
            print("Fetch user error", error)
        }
        return users
     }
}
