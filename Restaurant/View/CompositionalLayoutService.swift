import UIKit

class CompositionalLayoutService {
    static let shared = CompositionalLayoutService();
    
    private init() {}
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            
            switch sectionIndex {
                case 0:
                    let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(64), heightDimension: .absolute(64))
                    let item = NSCollectionLayoutItem(layoutSize: itemSize)
                    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(64))
                    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 5)
                    group.interItemSpacing = .fixed(8)
                    let section = NSCollectionLayoutSection(group: group)
                    section.interGroupSpacing = 8
                    section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                    section.contentInsets = .init(top: 0, leading: 0, bottom: 8, trailing: 0)
                    return section
                case 1:
                    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
                    let item = NSCollectionLayoutItem(layoutSize: itemSize)
                    
                    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5))
        //            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
                    //еще так можно:
                    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
                    let section = NSCollectionLayoutSection(group: group)
                    section.interGroupSpacing = 8
                    return section
                default: return nil
            }
        }
        return layout
    }
}
