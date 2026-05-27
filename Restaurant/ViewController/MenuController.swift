import UIKit

class MenuController: UIViewController {
    
    let mainView = MenuView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        navigationItem.title = "Блюда и напитки"
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
    }

}

extension MenuController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
   //колво элементов в секции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
            case 0: return 20
            case 1: return ProductsSource.products.count
            default: return 0
        }
        
       
    }
    //создает заполняет и возвращает ячейку
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoriesCell.reuseID, for: indexPath)
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseID, for: indexPath) as! ProductCell
                let product = ProductsSource.products[indexPath.item]
                cell.titleLabel.text = product.title
                cell.priceLabel.text = "\(product.price) ₽"
                if let imageName = product.imageName {
                    cell.productImageView.image = UIImage(named: imageName)
                } else
                {
                cell.productImageView.image = UIImage(systemName: "photo")
                }
                return cell
                
            default: return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0: print("Иcтория \(indexPath.item)")
        case 1: print("Блюдо: \(ProductsSource.products[indexPath.item].title)")
        default: break
        }
    }
}
