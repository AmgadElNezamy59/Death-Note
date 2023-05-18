
import UIKit

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        perform(#selector(self.ShowNavControoler), with: nil, afterDelay: 2)    }
    

    @objc func ShowNavControoler(){
        performSegue(withIdentifier: "toMainController", sender: self)
    }

}
