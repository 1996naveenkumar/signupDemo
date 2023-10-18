import UIKit

class EmployeeProfileVC: UIViewController {
// MARK: Outlets and Variables------------------------------------>
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtDesignation: UITextField!
    @IBOutlet weak var txtExperience: UITextField!
    
    let manager = DatabaseManager()
    var employee = EmployeeEntity()
    
    var designationArray = ["Employee Designation","iOS","Android","Java","Flutter","React"]
    var ExperienceArray = ["Employee Experience","0-1","1-5","5-7","7-10","10+"]
    
//    var StatusVC = EmployeeStatusVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
//        buttonCondition()
        self.hideKeyboardWhenTappedAround()
        imageView() //MARK: Is it needed?-----------<<<<

        btnSubmit.layer.cornerRadius = 20
        btnSubmit.layer.masksToBounds = true
    }
    
// MARK: CornerRadius and Shadow------------------------>
    func imageView() {
        imgProfile.layer.cornerRadius = imgProfile.frame.height/2
//      imgProfile.layer.masksToBounds = true <---<-----<-----<-------<---------<<<<
        imgProfile.layer.shadowRadius = 5
        imgProfile.layer.shadowColor = UIColor.red.cgColor
        imgProfile.layer.shadowOpacity = 5.0
        imgProfile.layer.shadowOffset = CGSize(width: 5 , height: 5)

        let profileShadowPath = UIBezierPath(roundedRect: imgProfile.bounds, byRoundingCorners: [.topLeft,.topRight,.bottomRight,.bottomLeft], cornerRadii: CGSize(width: 80, height: 80))
            imgProfile.layer.shadowPath = profileShadowPath.cgPath
        }
    
// MARK: Function for image picker action for camera and photo library--------------------->
    func getImage(fromSourceType sourceType: UIImagePickerController.SourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
//            imagePickerController.mediaTypes = [kUTTypeImage as String]
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        } else {
            print("Source type isn't available")
        }
    }
    
    
//    func buttonCondition(){
//        if employee != nil {
//            txtName.text = employee.name
//            txtDesignation.text = employee.designation
//            txtExperience.text = employee.experience
//            btnSubmit.setTitle("Update", for: .normal)
//        } else {
//            btnSubmit.setTitle("Submit", for: .normal)
//        }
//    }
    
// MARK: Profile image selector----------------------->
    @IBAction func btnEmployeeProfile(_ sender: UIButton) {

    let actionSheet = UIAlertController(title: "Add a photo", message: "Choose a file type to add", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.getImage(fromSourceType: .camera) //MARK: permissson required for camera----------<<<<
            print("User choose camera")
        }))
        
// MARK: Permission-------------<<<<
//            UIAlertAction(title: "Camera", style: .default, handler: { (action) -> Void in
//                        self.authorisationStatus(attachmentTypeEnum: .camera, vc: self.currentVC!)
//                    })
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {_ in
            self.getImage(fromSourceType: .photoLibrary) //MARK: permissson required for photoLibrary---<<<<
            print("User choose photo library")
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (_) in
            print("User dismiss adding photo")
        }))
        present(actionSheet, animated: true)
   }
    
// MARK: Adding employee data (Submit buttton)----------------------->
    @IBAction func btnSubmit(_ sender: UIButton) {
        
        if txtName.text != "" && txtDesignation.text != "" && txtExperience.text != "" {
            let name = txtName.text
            let designation = txtDesignation.text
            let experience = txtExperience.text
            
            let user = UserModel(
                name: name,
                designation: designation,
                experience: experience
            )
            manager.addUser(user)
            let alert = UIAlertController(title: nil, message: "User details added", preferredStyle: .alert)
            let actionOK = UIAlertAction(title: "OK", style: .default, handler: {_ in
                self.navigationController?.popViewController(animated: true)
            })
            alert.addAction(actionOK)
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: nil, message: "Fill all details", preferredStyle: .alert)
            let actionOK = UIAlertAction(title: "OK", style: .default)
            alert.addAction(actionOK)
            present(alert, animated: true)
        }
    }
}

extension EmployeeProfileVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
// MARK: Function for profile imagePickerController-------------------------->
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imgProfile.image  = image
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}


// MARK: Function for butttonPicker-------------------------->
//extension EmployeeProfileVC : UIPickerViewDataSource, UIPickerViewDelegate {
//
//        func numberOfComponents(in pickerView: UIPickerView) -> Int {
//            return 1
//        }
//
//        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//            return designationArray.count
//        }
//
//        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//            return designationArray[row]
//        }
//
//        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//            let selectedOption = designationArray[row]
//
//        }
//
//    }

