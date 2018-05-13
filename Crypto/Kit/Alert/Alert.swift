import UIKit

typealias AlertClosure = (_ index: Int) -> ()
typealias AlertActionClosure = (AlertAction) -> ()

struct AlertAction: Equatable {
    let title: String?
    let style: UIAlertActionStyle
    
    init(title: String?, style: UIAlertActionStyle) {
        self.title = title
        self.style = style
    }
    
    init(from action: UIAlertAction) {
        title = action.title
        style = action.style
    }
    
    // MARK: - Equatable
    static func ==(lhs: AlertAction, rhs: AlertAction) -> Bool {
        return lhs.title == rhs.title && lhs.style == rhs.style
    }
}

class Alert: NSObject {
    
    // MARK: - Variables
    var alertController: UIAlertController?
    
    // MARK: - Class methods
    @discardableResult
    class func alert(title: String?, message: String?) -> Alert {
        let alert = Alert()
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.alertController = alertController
        return alert
    }
    
    @discardableResult
    class func showNoYes(title: String?, message: String?, show controller: UIViewController!, completion: AlertClosure?) -> Alert {
        let alert = Alert.alert(title: title, message: message)

        let yesAction = UIAlertAction(title: "Yes", style: .default) { (alertAction) in
            if completion != nil {
                completion!(1)
            }
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel) { (alertAction) in
            if completion != nil {
                completion!(0)
            }
        }
        
        alert.alertController?.addAction(yesAction)
        alert.alertController?.addAction(noAction)
        alert.show(in: controller)
        return alert
    }
    
    @discardableResult
    class func showOk(title: String?, message: String?, show controller: UIViewController!, completion: AlertClosure?) -> Alert {
        let alert = Alert.alert(title: title, message: message)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alertAction) in
            if completion != nil {
                completion!(0)
            }
        }
        
        alert.alertController?.addAction(okAction)
        alert.show(in: controller)
        return alert
    }
    
    @discardableResult
    class func show(title: String?, message: String?, actions: [AlertAction], in controller: UIViewController!, completion: AlertActionClosure?) -> Alert
    {
        let alert = Alert.alert(title: title, message: message)
        actions.forEach { (action) in
            alert.add(action: action, completion: completion)
        }
        alert.show(in: controller)
        return alert
    }

    // MARK: - Public methods
    func add(action: AlertAction, completion: AlertActionClosure?) {
        if self.alertController != nil {
            let uiAlertAction = UIAlertAction(title: action.title, style: action.style, handler: { (action) in
                completion?(AlertAction(from: action))
            })
            self.alertController!.addAction(uiAlertAction)
        }
    }
    
    func show(in controller: UIViewController?) {
        if self.alertController != nil {
            
            func showFrom(controller: UIViewController) {
                controller.present(self.alertController!, animated: true, completion: nil)
            }
            
            if controller != nil {
                showFrom(controller: controller!)
            } else {
                if let topController = UIViewController.topController() {
                    showFrom(controller: topController)
                }
            }
            
        }
    }
    
    func show(from navigation: UINavigationController) {
        navigation.present(self.alertController!, animated: true, completion: nil)
    }
    
}
