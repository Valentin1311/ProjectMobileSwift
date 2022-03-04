import SwiftUI

struct NewFiche2Page: View {
    @Binding var mainPageIndex: Int
    @Binding var NFindex: Int
    @State private var index = 0
    @State var meal : MealDTO
    @State var showConfirmAlert = false
    @State var showNotConformMealAlert = false
    @State var showStageChoiceAlert = false
    @State var existingMealChose = false
    @State var existingMealSelected : MealDTO?
    var body: some View {
        VStack {
            TabView(selection: $index) {
                ForEach((0..<meal.stageList.count), id: \.self) { index in
                    StageView(vm: StagePageVM(stage: meal.stageList[index]), stageIndex: index, editable: true)
                }
            }.tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
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
                            self.mainPageIndex = 0
                            self.meal = MealDTO(id: nil, name: "", manager: "", category: Categories.entree.rawValue, nbGuests: 0, stageList: [StageDTO(name: "", description: "", ingredients: [], duration: nil)], matS: nil, matD: nil, coefVenteHT: nil, coefVenteTTC: nil, coutHFluide: nil, coutHMoyen: nil)
                            self.NFindex = 0
                        }
                    }.alert("Chaque étape doit avoir au moins un nom et une description", isPresented: $showNotConformMealAlert) {
                        Button("OK", role: .cancel) {}
                    }
                    Text("\(index + 1)/\(meal.stageList.count)").font(.headline)
                }
                NavigationLink(destination: HomePage(editable: false, existingMealSelected: $existingMealSelected), isActive: $existingMealChose) { EmptyView() }
                Spacer()
                Button(action: {
                    self.showStageChoiceAlert = true
                }) {
                    Image(systemName: "plus.square.on.square")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30).foregroundColor(.accentColor).padding(10).overlay(Circle().stroke(Color.black, lineWidth: 2))
                }.alert("Quel type d'étape voulez-vous créer ?", isPresented: $showStageChoiceAlert) {
                    Button("Nouvelle étape") {
                        self.addTabItem(index: index)
                    }
                    Button("Etape existante") {
                        existingMealChose = true
                    }
                    Button("Annuler", role: .cancel) {}
                }
            }.padding()
        }.navigationBarTitle("", displayMode: .inline)
        .padding(.vertical)
        .onAppear { 
            if let existingMealSelected = existingMealSelected {
                existingMealSelected.stageList.forEach { stage in
                    self.addTabItem(index: index, stage: stage)
                }
            }
        }
    }
    
    func addTabItem(index: Int, stage: StageDTO = StageDTO(name: "", description: "", ingredients: [], duration: nil)) {
        meal.stageList.insert(stage, at: index + 1)
        meal.stageList.forEach { stage in
            stage.ingredients.forEach { ingredient in
                let pokeMirror = Mirror(reflecting: ingredient)
                let properties = pokeMirror.children
                for property in properties {
                  print("\(property.label!) = \(property.value)")
                }
            }
            print("-----------------------------------")
        }
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
