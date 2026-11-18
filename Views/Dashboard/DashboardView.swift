
import SwiftUI

struct DashboardView: View {

    @EnvironmentObject var mealViewModel: MealViewModel

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(alignment: .leading, spacing: 20) {

                    // MARK: - Heading

                    VStack(alignment: .leading, spacing: 5) {

                        Text("Weekly Meal Planner")
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        Text("Your weekly meal overview")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    // MARK: - Dashboard Cards

                    LazyVGrid(
                        columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ],
                        spacing: 15
                    ) {

                        dashboardCard(
                            title: "Total Meals",
                            count: mealViewModel.meals.count,
                            symbol: "fork.knife",
                            color: .blue
                        )

                        dashboardCard(
                            title: "Cooked",
                            count: cookedCount,
                            symbol: "checkmark.circle.fill",
                            color: .green
                        )

                        dashboardCard(
                            title: "Planned",
                            count: plannedCount,
                            symbol: "calendar",
                            color: .orange
                        )

                        dashboardCard(
                            title: "Skipped",
                            count: skippedCount,
                            symbol: "xmark.circle.fill",
                            color: .red
                        )
                    }

                    // MARK: - Upcoming Meal

                    VStack(alignment: .leading, spacing: 12) {

                        Text("Upcoming Meals")
                            .font(.title2)
                            .fontWeight(.bold)

                        if let nextMeal = mealViewModel.meals.first(
                            where: { $0.status == .planned }
                        ) {

                            VStack(alignment: .leading, spacing: 8) {

                                Text(nextMeal.dishName)
                                    .font(.headline)

                                Text("\(nextMeal.day.rawValue) - \(nextMeal.mealType.rawValue)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)

                                Text("Servings: \(nextMeal.servings)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(Color.gray.opacity(0.12))
                            .cornerRadius(15)

                        } else {

                            Text("No upcoming meals planned.")
                                .foregroundColor(.secondary)
                                .padding()
                        }
                    }

                    // MARK: - Recent Meals

                    VStack(alignment: .leading, spacing: 12) {

                        Text("Your Meals")
                            .font(.title2)
                            .fontWeight(.bold)

                        if mealViewModel.meals.isEmpty {

                            Text("No meals added yet.")
                                .foregroundColor(.secondary)

                        } else {

                            ForEach(mealViewModel.meals) { meal in

                                HStack {

                                    VStack(alignment: .leading, spacing: 5) {

                                        Text(meal.dishName)
                                            .fontWeight(.semibold)

                                        Text("\(meal.day.rawValue) • \(meal.mealType.rawValue)")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }

                                    Spacer()

                                    Text(meal.status.rawValue)
                                        .font(.caption)
                                        .foregroundColor(.green)
                                }
                                .padding()
                                .background(Color.gray.opacity(0.12))
                                .cornerRadius(12)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Dashboard")
        }
    }

    // MARK: - Meal Counts

    private var cookedCount: Int {
        mealViewModel.meals.filter {
            $0.status == .cooked
        }.count
    }

    private var plannedCount: Int {
        mealViewModel.meals.filter {
            $0.status == .planned
        }.count
    }

    private var skippedCount: Int {
        mealViewModel.meals.filter {
            $0.status == .skipped
        }.count
    }

    // MARK: - Dashboard Card

    private func dashboardCard(
        title: String,
        count: Int,
        symbol: String,
        color: Color
    ) -> some View {

        VStack(alignment: .leading, spacing: 12) {

            Image(systemName: symbol)
                .font(.title2)
                .foregroundColor(color)

            Text("\(count)")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.gray.opacity(0.12))
        .cornerRadius(15)
    }
}
