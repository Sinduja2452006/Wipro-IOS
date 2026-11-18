
import SwiftUI

struct MealFormView: View {

    @Binding var dishName: String
    @Binding var day: Weekday
    @Binding var mealType: MealType
    @Binding var servings: Int
    @Binding var notes: String

    var body: some View {

        Form {

            Section("Meal Information") {

                TextField("Dish Name", text: $dishName)

                Picker("Day", selection: $day) {
                    ForEach(Weekday.allCases) { day in
                        Text(day.rawValue).tag(day)
                    }
                }

                Picker("Meal Type", selection: $mealType) {
                    ForEach(MealType.allCases) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
            }

            Section("Additional Information") {

                Stepper(
                    "Servings: \(servings)",
                    value: $servings,
                    in: 1...20
                )

                TextField(
                    "Ingredients or Notes",
                    text: $notes,
                    axis: .vertical
                )
                .lineLimit(3...5)
            }
        }
    }
}
