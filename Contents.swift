import UIKit

// オブジェクトテンプレートパターンを採用していない場合
var products = [
    ("Kayak", "A boat for one person", 275.0, 10),
    ("Lifejacket", "Protective and fashionable", 48.95, 14),
    ("Soccer Ball", "FIFA-approved size and weight", 19.5, 32)
]

// 一商品の税金の計算
func calculateTax(product: (String, String, Double, Int)) -> Double {
    return product.2 * 0.2
}

// 全ての商品の在庫価格
func calculateStockValue(tuples: [(String, String, Double, Int)]) -> Double {
    return tuples.reduce(0, { (total, product) -> Double in
        return total + (product.2 * Double(product.3))
    })
}

print("Sales tax for Kayak: $\(calculateTax(product: products[0]))")
print("Total value of stock: $\(calculateStockValue(tuples: products))")






// オブジェクトテンプレートパターンを採用した場合
class Product {
    var name: String
    var description: String
    var price: Double
    private var stockBackingValue = 0
    var stock: Int {
        get {
            return stockBackingValue
        }
        set {
            stockBackingValue = max(0, newValue)
        }
    }
    
    init(name: String, description: String, price: Double, stock: Int) {
        self.name = name
        self.description = description
        self.price = price
        self.stock = stock
    }
    
    // 一商品の税金の計算
    func calculateTax(rate: Double) -> Double {
        return self.price * rate
    }
    
    // 在庫価格
    var stockValue: Double {
        return self.price * Double(self.stock)
    }
}

// 全ての商品の在庫価格
func calculateStockValue(productsArray: [Product]) -> Double {
    return productsArray.reduce(0, { (total, product) -> Double in
        return total + product.stockValue
    })
}

var product = [
    Product(name: "Kayak", description: "A boat for one persion", price: 275, stock: 10),
    Product(name: "Lifejacket", description: "Protective and fashionable", price: 48.95, stock: 14),
    Product(name: "Soccer Ball", description: "FIFA-approved size and weight", price: 19.5, stock: 32)
]

print("Sales tax for Kayak: $\(product[0].calculateTax(rate: 0.2))")
print("Total value of stock: $\(calculateStockValue(productsArray: product))")
product[0].stock = -50
print("Stock Level for Kayak: \(product[0].stock)")
