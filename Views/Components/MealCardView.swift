
import SwiftUI

struct MealCardView: View {

    @EnvironmentObject var mealViewModel: MealViewModel

    let meal: Meal

    var body: some View {

        VStack(alignment: .leading, spacing: 10) {

            Text(meal.dishName)
                .font(.headline)

            Text("\(meal.day.rawValue) - \(meal.mealType.rawValue)")
                .font(.subheadline)
                .foregroundColor(.secondary)

            Text("Servings: \(meal.servings)")
                .font(.caption)

            Text(meal.status.rawValue)
                .font(.caption)
        }
        .padding()
        .background(Color.gray.opacity(0.12))
        .cornerRadius(12)
    }
}

