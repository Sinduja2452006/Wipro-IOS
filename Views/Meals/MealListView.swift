
import SwiftUI

struct MealListView: View {

    @EnvironmentObject var viewModel: MealViewModel

    @State private var searchText = ""
    @State private var selectedDay: Weekday?
    @State private var selectedType: MealType?
    @State private var showAddMeal = false

    // MARK: - Filtered Meals

    private var displayedMeals: [Meal] {

        viewModel.filteredMeals(
            keyword: searchText,
            day: selectedDay,
            mealType: selectedType
        )
    }

    // MARK: - Body

    var body: some View {

        List {

            // MARK: - Search & Filter

            Section("Search & Filter") {

                Picker("Day", selection: $selectedDay) {

                    Text("All Days")
                        .tag(nil as Weekday?)

                    ForEach(Weekday.allCases) { day in

                        Text(day.rawValue)
                            .tag(day as Weekday?)
                    }
                }

                Picker("Meal Type", selection: $selectedType) {

                    Text("All Types")
                        .tag(nil as MealType?)

                    ForEach(MealType.allCases) { type in

                        Text(type.rawValue)
                            .tag(type as MealType?)
                    }
                }
            }

            // MARK: - Meal List

            if displayedMeals.isEmpty {

                Text("No meals found")
                    .foregroundColor(.secondary)

            } else {

                ForEach(Weekday.allCases) { day in

                    let dayMeals = displayedMeals.filter {
                        $0.day == day
                    }

                    if !dayMeals.isEmpty {

                        Section(day.rawValue) {

                            ForEach(dayMeals) { meal in

                                NavigationLink {

                                    MealDetailView(meal: meal)

                                } label: {

                                    MealCardView(meal: meal)
                                }
                            }
                        }
                    }
                }
            }
        }

        .searchable(
            text: $searchText,
            prompt: "Search dish name"
        )

        .navigationTitle("Meal Plan List")

        // MARK: - Add Meal Button

        .toolbar {

            ToolbarItem(placement: .automatic) {

                Button {

                    showAddMeal = true

                } label: {

                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                }
            }
        }

        // MARK: - Add Meal Sheet

        .sheet(isPresented: $showAddMeal) {

            NavigationStack {

                AddMealView()
                    .environmentObject(viewModel)
            }
        }
    }
}
