import UIKit

final class TabBarController: UITabBarController {
    
    private let orderVC = OrderViewController()
    private let productsVC = MenuController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [
            makeNavVC(rootVC: orderVC, title: "Заказ", image: UIImage(systemName: "note.text")!),
            makeNavVC(rootVC: productsVC, title: "Меню", image: UIImage(systemName: "filemenu.and.selection")!)
        ]
    }
    
    private func makeNavVC(rootVC: UIViewController, title: String, image: UIImage) -> UINavigationController {
        let vc = UINavigationController(rootViewController: rootVC)
        vc.tabBarItem.title = title
        vc.tabBarItem.image = image
        return vc
    }
}
