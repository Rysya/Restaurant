import Foundation

struct OrderPosition {
    let product: Product
    var count: Int
    var cost: Int {
        product.price * count
    }
}
