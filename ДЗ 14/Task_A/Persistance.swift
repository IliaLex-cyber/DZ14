
import Foundation

class Persistance{
    static let shared = Persistance()
    
    private let kUserNameKey = "Persistance.kUserNameKey"
    var userName: String? {
        set { UserDefaults.standard.set(newValue, forKey: kUserNameKey)}
        get { return UserDefaults.standard.string(forKey: kUserNameKey)}
    }
    private let kUserSurnameKey = "Persistance.kUserSurnameKey"
    var userSurname: String? {
        set { UserDefaults.standard.set(newValue, forKey: kUserSurnameKey)}
        get { return UserDefaults.standard.string(forKey: kUserSurnameKey)}
    }
}
