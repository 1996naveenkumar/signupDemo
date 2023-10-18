import UIKit

class SignUpVC: UIViewController {
// MARK: Outlets------------------------------------>
    @IBOutlet weak var signupView: UIView!
    @IBOutlet weak var buttonSignUp: UIButton!
    
    @IBOutlet weak var textUsername: UITextField!
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var textPasswordConfirm: UITextField!
  
    @IBOutlet weak var lblUser: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var lblCPassword: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        self.hideKeyboardWhenTappedAround()
        layoutView()
        
// MARK: SignUp button CornerRadius------------------------>
        buttonSignUp.layer.cornerRadius = 20
        buttonSignUp.clipsToBounds = true
        
// MARK: Hiding labels for signUp conditions------------------------>
        lblUser.isHidden = true
        lblEmail.isHidden = true
        lblPassword.isHidden = true
        lblCPassword.isHidden = true
    }
    
// MARK: Alert action function----------------------------->
    func popAlert(Title : String, Description : String) {
        let alert = UIAlertController(title: Title, message: Description, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
// MARK: Functions for username, email and password validation------------------------>
    func validateUsername(_ username: String) -> Bool {
        let userRegex = "\\w{7,18}"
        let userPredicate = NSPredicate(format: "SELF MATCHES %@", userRegex)
        return userPredicate.evaluate(with: username)
    }
    
    func validateEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }

    func validatePassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,15}$"
        debugPrint(passwordRegex)
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }

    @IBAction func btnSignUp(_ sender: UIButton) {
// MARK: Validation, Warning message and Alert action for username, email and password------------------------>
        if validateUsername(textUsername.text!.lowercased()) {
              print("Valid username")
          } else {
              popAlert(Title: "Alert!", Description: "Enter a valid username")
              lblUser.isHidden = false
              print("Invalid username")
          }
        
        if validateEmail(textEmail.text!) {
              print("Valid email")
          } else {
              popAlert(Title: "Alert!", Description: "Enter a valid email")
              lblEmail.isHidden = false
              print("Invalid email")
          }

        if validatePassword(textPassword.text!) {
            print("Password is valid")
        } else {
            popAlert(Title: "Alert!", Description: "Enter a valid password")
            lblPassword.isHidden = false
            print("Password is invalid")
        }

        if textPasswordConfirm.text == textPassword.text {
            print("Password is confirmed")
        } else {
            popAlert(Title: "Alert", Description: "Enter a matching password")
            lblCPassword.isHidden = false
            print("Password is not same")
        }
        
// MARK: Navigation to Employee Profile ViewController---------------------->
        let strStatus = UIStoryboard(name: "Main", bundle: nil)
        let statusVC = strStatus.instantiateViewController(withIdentifier: "EmployeeStatusVC") as! EmployeeStatusVC
        self.navigationController?.pushViewController(statusVC, animated: true)
    }
    
// MARK: Navigation to Login ViewController---------------------->
    @IBAction func btnLogin(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension SignUpVC {
// MARK: signupView CornerRadius and Shadow------------------------>
    func layoutView() {
        signupView.layer.cornerRadius = 80
        signupView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        signupView.layer.shadowColor = UIColor.lightGray.cgColor
        signupView.layer.shadowOpacity = 5.0
        signupView.layer.shadowOffset = CGSize(width: 5, height: 5)
        signupView.layer.shadowRadius = 5

        let shadowPath = UIBezierPath(roundedRect: signupView.bounds, byRoundingCorners: [.topLeft, .bottomRight], cornerRadii: CGSize(width: 80, height: 80))
        signupView.layer.shadowPath = shadowPath.cgPath
    }
}
