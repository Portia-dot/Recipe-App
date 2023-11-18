// MARK: - Nutrition
struct Nutrition: Codable {
    let vegetarian, vegan, glutenFree, dairyFree: Bool?
    let veryHealthy, cheap, veryPopular, sustainable: Bool?
    let lowFodmap: Bool?
    let weightWatcherSmartPoints: Int?
    let gaps: String?
    let preparationMinutes, cookingMinutes, aggregateLikes, healthScore: Int?
    let creditsText, license, sourceName: String?
    let pricePerServing: Double?
    let extendedIngredients: [ExtendedIngredient]?
    let id: Int?
    let title: String?
    let readyInMinutes, servings: Int?
    let sourceURL: String?
    let image: String?
    let imageType: String?
    let nutrition: NutritionClass?
    let summary: String?
    let cuisines: [JSONAny]?
    let dishTypes: [String]?
    let diets, occasions: [JSONAny]?
    let winePairing: WinePairing?
    let instructions: String?
    let analyzedInstructions: [JSONAny]?
    let originalID: JSONNull?
    let spoonacularScore: Double?
    let spoonacularSourceURL: String?

    enum CodingKeys: String, CodingKey {
        case vegetarian, vegan, glutenFree, dairyFree, veryHealthy, cheap, veryPopular, sustainable, lowFodmap, weightWatcherSmartPoints, gaps, preparationMinutes, cookingMinutes, aggregateLikes, healthScore, creditsText, license, sourceName, pricePerServing, extendedIngredients, id, title, readyInMinutes, servings
        case sourceURL = "sourceUrl"
        case image, imageType, nutrition, summary, cuisines, dishTypes, diets, occasions, winePairing, instructions, analyzedInstructions
        case originalID = "originalId"
        case spoonacularScore
        case spoonacularSourceURL = "spoonacularSourceUrl"
    }
}

// MARK: - ExtendedIngredient
struct ExtendedIngredient: Codable{
    let id: Int?
    let aisle, image: String?
    let consistency: Consistency?
    let name, nameClean, original, originalName: String?
    let amount: Double?
    let unit: String?
    let meta: [String]?
    let measures: Measures?
}

enum Consistency: String, Codable {
    case liquid = "LIQUID"
    case solid = "SOLID"
}

// MARK: - Measures
struct Measures: Codable {
    let us, metric: Metric?
}

// MARK: - Metric
struct Metric: Codable {
    let amount: Double?
    let unitShort, unitLong: String?
}

// MARK: - NutritionClass
struct NutritionClass: Codable {
    let nutrients, properties, flavonoids: [Flavonoid]?
    let ingredients: [Ingredient]?
    let caloricBreakdown: CaloricBreakdown?
    let weightPerServing: WeightPerServing?
}

// MARK: - CaloricBreakdown
struct CaloricBreakdown: Codable {
    let percentProtein, percentFat, percentCarbs: Double?
}

// MARK: - Flavonoid
struct Flavonoid: Codable {
    let name: String?
    let amount: Double?
    let unit: Unit?
    let percentOfDailyNeeds: Double?
}

enum Unit: String, Codable {
    case empty = ""
    case g = "g"
    case iu = "IU"
    case kcal = "kcal"
    case mg = "mg"
    case unit = "%"
    case µg = "µg"
}

// MARK: - Ingredient
struct Ingredient: Codable {
    let id: Int?
    let name: String?
    let amount: Double?
    let unit: String?
    let nutrients: [Flavonoid]?
}

// MARK: - WeightPerServing
struct WeightPerServing: Codable {
    let amount: Int?
    let unit: Unit?
}

// MARK: - WinePairing
struct WinePairing: Codable {
    let pairedWines: [JSONAny]?
    let pairingText: String?
    let productMatches: [JSONAny]?
}
