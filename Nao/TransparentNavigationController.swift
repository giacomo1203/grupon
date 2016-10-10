

import UIKit

class TransparentNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Avenir-Light", size: 15.0)!]

        navigationBar.setBackgroundImage(UIImage.fromColor(.clearColor()), forBarMetrics: .Default)
        navigationBar.translucent = true
        navigationBar.tintColor = UIColor.whiteColor()

        self.navigationBar.shadowImage = UIImage()
        self.interactivePopGestureRecognizer!.enabled = false
 
    }
}
