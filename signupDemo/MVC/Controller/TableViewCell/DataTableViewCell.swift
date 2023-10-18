import UIKit

class DataTableViewCell: UITableViewCell {
// MARK: Cell variables----------------------->
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    @IBOutlet weak var lblExperience: UILabel!

    
//    var employee = EmployeeEntity?() {  // MARK: To edit data---------<<<<
//        didSet {
//            employeeConfiguration()
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
//    func employeeConfiguration(){
//        guard let employee else { return }
//        lblName.text = employee.name
//        lblDesignation.text = employee.designation
//        lblExperience.text = employee.experience
//    }
}
