import UIKit

class ViewController: UIViewController {
// MARK: Outlets---------------------------------->
    @IBOutlet weak var textUserName: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var subView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationItem.hidesBackButton = true
        buttonLogin.layer.cornerRadius = 20
        buttonLogin.clipsToBounds = true
        hideKeyboardWhenTappedAround()
    
        subView.roundCorners(corners: [.topLeft, .bottomRight], radius: 80)
    }
    
    @IBAction func buttonLogin(_ sender: UIButton) {
// MARK: Add here user dataBase to validate--------------------<<<<
  
// MARK: Condition to restrict user to pass empty textField------------------------>
        if textUserName.text == "" || textPassword.text == "" {
            let alert = UIAlertController(title: "Alert!", message: "Please enter your username and password", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(action)
           present(alert, animated: true)
        } else {
// MARK: Navigation from login to Profile ViewController------------------------>
            let strProfile = UIStoryboard(name: "Main", bundle: nil)
            let profileVC = strProfile.instantiateViewController(withIdentifier: "EmployeeStatusVC") as! EmployeeStatusVC
            self.navigationController?.pushViewController(profileVC, animated: true)
            print("User logged in")
        }
    }
    
// MARK: Navigation to SignUp ViewController------------------------>
    @IBAction func buttonSignUp(_ sender: UIButton) {
            let strSignUp = UIStoryboard.init(name: "Main", bundle: nil)
            let signUp = strSignUp.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
            self.navigationController?.pushViewController(signUp, animated: true)
    }
}

// MARK: Extension for roundCorner function---------------------->
extension UIView {
    func roundCorners(corners: UIRectCorner, radius: Int) {
        let maskPath1 = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: corners,
                                     cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = bounds
        maskLayer1.path = maskPath1.cgPath
        layer.mask = maskLayer1
    }
}

// MARK: Extension for dissmiss keyboard function---------------------->
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
