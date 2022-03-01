import SwiftUI

struct NewFiche2Page: View {
    @State private var index = 0
    @State var meal : MealDTO
    @State var showConfirmAlert = false
    @State var showNotConformMealAlert = false
    var body: some View {
        VStack {
          //  ScrollView {
                TabView(selection: $index) {
                    ForEach((0..<meal.stageList.count), id: \.self) { index in
                        StageView(stage: meal.stageList[index], vm: StagePageVM(), stageIndex: index, editable: true)
                    }
              //  }
            }.tabViewStyle(PageTabViewStyle())
            .id(meal.stageList.count)
            .onAppear {
              setupAppearance()
            }
            HStack(alignment: .center, spacing: 5) {
                Button(action: {
                    showConfirmAlert = true
                }) {
                    Image(systemName: "trash")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30).foregroundColor(.accentColor).padding(10).overlay(Circle().stroke(Color.black, lineWidth: 2))
                }.disabled(meal.stageList.count <= 1).alert("Êtes-vous sûr de vouloir supprimer cette étape", isPresented: $showConfirmAlert) {
                    Button("Oui") {
                        if meal.stageList.count > 1 { self.removeTabItem(index: index) }
                    }
                    Button("Non") {}
                }
                Spacer()
                VStack() {
                    Button("Terminer") {
                        var addToDB = true
                        meal.stageList.forEach { stage in
                            if stage.name == "" || stage.description == "" {
                                showNotConformMealAlert = true
                                addToDB = false
                            }
                        }
                        if addToDB {
                            MealDAO().updateOrAddMeal(meal: meal)
                        }
                    }.alert("Chaque étape doit avoir au moins un nom et une description", isPresented: $showNotConformMealAlert) {
                        Button("OK", role: .cancel) {}
                    }
                    Text("\(index + 1)/\(meal.stageList.count)").font(.headline)
                }
                Spacer()
                Button(action: {
                    self.addTabItem(index: index)
                }) {
                    Image(systemName: "plus.square.on.square")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30).foregroundColor(.accentColor).padding(10).overlay(Circle().stroke(Color.black, lineWidth: 2))
                }
            }.padding()
        }.navigationBarTitle("", displayMode: .inline)
    }
    
    func addTabItem(index: Int) {
        meal.stageList.insert(StageDTO(name: "", description: "", ingredients: [], duration: nil), at: index + 1)
        self.index += 1
    }
    
    func removeTabItem(index: Int) {
        if meal.stageList.count > 1 {
            meal.stageList.remove(at: index)
            self.index = index != 0 ? index - 1 : 0
        }
    }
    
    func setupAppearance() {
      UIPageControl.appearance().currentPageIndicatorTintColor = .black
      UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
}
