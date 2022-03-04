import Foundation
import FirebaseFirestore

class HomePageVM : ObservableObject{
    @Published var meals: [MealDTO] = []
    @Published var filteredMeals: [MealDTO] = []
    private let firestore = Firestore.firestore()
    private var mealDAO = MealDAO()
    
    init() {
        self.fetchMeals()
    }
    
    func fetchMeals() {
       firestore.collection("Meals").addSnapshotListener{ (data, error) in
         guard let documents = data?.documents else {
                return // no documents
         }
          self.meals = self.mealDAO.mapMeals(documents: documents)
          self.filteredMeals = self.meals
       }
    }
    
}
