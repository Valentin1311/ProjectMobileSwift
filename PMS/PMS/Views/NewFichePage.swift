import SwiftUI

struct NewFichePage: View {
    @State private var index = 0
    @State var meal: MealDTO = MealDTO(id: nil, name: "d", manager: "d", category: Categories.entree.rawValue, nbGuests: 6, stageList: [StageDTO(name: "", description: "", ingredients: [], duration: nil)], matS: nil, matD: nil, coefVenteHT: nil, coefVenteTTC: nil, coutHFluide: nil, coutHMoyen: nil)
    @State var swipeEnabled = false
    @State var showAlert = false
    var body: some View {
        NavigationView {
            VStack() {
                HStack(alignment: .top, spacing: 15) {
                    ZStack {
                        Circle().stroke(.green, lineWidth: 4)
                      Text("1")
                    }.frame(width: 40, height: 40)
                    ZStack {
                        Circle().stroke(changeColor2(color: index), lineWidth: 4)
                      Text("2")
                    }.frame(width: 40, height: 40)
                    ZStack {
                        Circle().stroke(changeColor3(color: index), lineWidth: 4)
                      Text("3")
                    }.frame(width: 40, height: 40)
                }
                TabView(selection: $index) {
                    ForEach((0..<3), id: \.self) { index in
                        TabsView(meal: meal, index: index)
                            .padding(.horizontal, 30)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .contentShape(Rectangle())
                            .gesture(swipeEnabled ? nil : DragGesture())
                    }
                    
                 }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                Spacer()
                HStack() {
                    Button(action: {
                        if index != 0 { index -= 1 }
                    }) {
                        Text("Précédent")
                    }.isHidden(index == 0)
                    Spacer()
                    Button(action: {
                        if index == 0 {
                            if meal.name != "" && meal.manager != "" && meal.nbGuests != 0 {
                                showAlert = false
                                index += 1
                            }
                            else {
                                showAlert = true
                            }
                        }
                        else if index == 1 {
                            index += 1
                        }
                    }) {
                        if index == 0 {
                            Text("Suivant")
                        }
                        else if index == 1 {
                            Text(meal.matS != "" || meal.matD != "" ? "Suivant" : "Ignorer")
                        }
                        else {
                            NavigationLink(destination: NewFiche2Page(meal: meal), isActive: !$showAlert) {
                                Text("Suivant")
                            }
                        }
                    }.alert("Veuillez renseigner tous les champs obligatoires", isPresented: $showAlert) {
                        Button("OK", role: .cancel) {}
                    }
                }
            }.padding().navigationBarTitle("Informations génerales", displayMode: .inline)
        }
    }
    
    func changeColor2(color: Int) -> Color
    {
        if(index >= 1)
        {
            return Color.green;
        }
        return Color.gray
    }
    
    func changeColor3(color: Int) -> Color
    {
        if(index >= 2)
        {
            return Color.green;
        }
        return Color.gray
    }
}

struct TabsView : View {
    @State var meal : MealDTO
    @State var index : Int
    var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.zeroSymbol = ""
        return formatter
    }()
    var body: some View {
        if index == 0 {
            VStack() {
                Text("Intitulé *").contentShape(Rectangle())
                TextField("Boeuf bourgignon", text: $meal.name).padding().overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 2))
                HStack() { Text("Catégorie *") }
                HStack() {
                    Spacer()
                    Picker("Catégories", selection: $meal.category) {
                        Text("Entrée").tag(Categories.entree)
                        Text("Plat").tag(Categories.plat)
                        Text("Dessert").tag(Categories.dessert)
                    }
                    Spacer()
                }.padding().overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 2))
                Text("Nombre de couverts *").contentShape(Rectangle())
                TextField("10", value: $meal.nbGuests, formatter: numberFormatter).padding().overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 2))
                Text("Responsable *").contentShape(Rectangle())
                TextField("Jean JACQUES", text: $meal.manager).padding().overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 2))
            }
        }
        if index == 1 {
            VStack() {
                Text("Matériel de dressage")
                TextField("5 couteaux argentés", text: $meal.matD ?? "").padding().overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 2))
                Text("Matériel spécifique")
                TextField("10 tables rondes", text: $meal.matS ?? "").padding().overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 2))
            }
        }
        if index == 2 {
            VStack() {
                Text("Coef. vente (avec charges) *")
                TextField("2", value: $meal.coefVenteTTC, formatter: numberFormatter).padding().overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 2))
                Text("Coef. vente (hors charges) *")
                TextField("3", value: $meal.coefVenteHT, formatter: numberFormatter).padding().overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 2))
                Text("Coût horraire fluide (en €) *")
                TextField("20", value: $meal.coutHFluide, formatter: numberFormatter).padding().overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 2))
                Text("Coût horraire moyen (en €) *")
                TextField("26", value: $meal.coutHMoyen, formatter: numberFormatter).padding().overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 2))
            }
        }
    }
}

// global function
func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}

prefix func ! (value: Binding<Bool>) -> Binding<Bool> {
    Binding<Bool>(
        get: { !value.wrappedValue },
        set: { value.wrappedValue = !$0 }
    )
}

enum Categories: String, CaseIterable, Identifiable {
    case entree, plat, dessert
    var id: Self { self }
} 

struct HiddenNavigationBar: ViewModifier {
    func body(content: Content) -> some View {
        content
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

extension View {
    func hiddenNavigationBarStyle() -> some View {
        modifier( HiddenNavigationBar() )
    }
}
