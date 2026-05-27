import Foundation

struct ProductsSource {
    static var products: [Product] = [
            Product(
                title: "Шашлык Машлык",
                price: 300,
                oldPrice: 400,
                description: "Шашлычок из баранины! Вчера бегал, отвечаю!",
                category: .hot,
                imageName: "Shashlyk"
            ),
            
            Product(
                title: "Пахлава",
                price: 200,
                oldPrice: nil,
                description: "Нежнейшая пахлава прямо из Турции!",
                category: .cakes
            ),
            
            Product(
                title: "Лагман",
                price: 350,
                oldPrice: 470,
                description: "просто лагман с домашней лапшой",
                category: .hot,
                imageName: "Lagman"
            ),
            
            Product(
                title: "Натахтари",
                price: 120,
                oldPrice: nil,
                description: "Лимонад из Грузии",
                category: .drink
            ),
            
            Product(
                title: "Кофе по-восточному",
                price: 160,
                oldPrice: 270,
                description: "Готовится в турке на песчаной бане",
                category: .drink
            ),
            
            Product(
                title: "Кофе по-европейски",
                price: 160,
                oldPrice: 270,
                description: "Готовится в турке на песчаной бане",
                category: .drink
            ),
            
            Product(
                title: "Кофе обыкновенный",
                price: 160,
                oldPrice: 270,
                description: "Готовится в турке на песчаной бане",
                category: .drink
            ),
            
            Product(
                title: "Кофе Латте",
                price: 160,
                oldPrice: 270,
                description: "Готовится в турке на песчаной бане",
                category: .drink
            ),
            
            Product(
                title: "Греческий салат",
                price: 320,
                oldPrice: nil,
                description: "Внезапно, да?",
                category: .salat
            ),
            
            Product(
                title: "Шашлык из овощей",
                price: 200,
                oldPrice: 300,
                description: "Грибы, овощи на гриле",
                category: .hot
            ),
            
            Product(
                title: "Оливье",
                price: 250,
                oldPrice: 300,
                description: "Специально для любителей майонеза",
                category: .salat
            ),
            
            Product(
                title: "Коньяк Арарат",
                price: 300,
                oldPrice: nil,
                description: "Ваш батя оценит!",
                category: .drink,
                imageName: "Conyak"
        )
    ]
}
