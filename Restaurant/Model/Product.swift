import Foundation

struct Product {
    let title: String
    let price: Int
    let oldPrice: Int?
    let description: String
    let category: ProductCategory
}

enum ProductCategory: String {
    case salat = "Салаты"
    case hot = "Горячие"
    case drink = "Напитки"
    case cakes = "Десерты"
}
