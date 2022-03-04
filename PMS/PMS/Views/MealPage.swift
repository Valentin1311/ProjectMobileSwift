import SwiftUI

struct MealPage: View {
    @State private var index = 0
    @Binding var meal: MealDTO
    @State private var editClicked = false
    @State var showConfirmAlert = false
    @State var oldNbGuests = 0
    @State var printClicked: Bool = false
    @State var infoClicked: Bool = false
    @StateObject var vm = MealPageVM()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            TabView(selection: $index) {
                ForEach((0..<meal.stageList.count), id: \.self) { index in
                    StageView(vm: StagePageVM(stage: meal.stageList[index]), stageIndex: index, editable: false)
                }
            }.tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            .onAppear {
              setupAppearance()
            }
            Spacer()
            HStack(spacing: 15) {
                HStack(alignment: .center, spacing: 10) {
                    Image(systemName: "fork.knife")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30).foregroundColor(.accentColor)
                    Text("\(meal.nbGuests)")
                    if editClicked {
                        Stepper("", value: $meal.nbGuests, in: 0...1000, step: 1)
                        Button(action: { editClicked = false; updateMeal() }) {
                            Image(systemName: "checkmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30).foregroundColor(.accentColor)
                        }
                        Spacer()
                    }
                    else {
                        Button(action: { editClicked = true }) {
                            Image(systemName: "pencil")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30).foregroundColor(.accentColor)
                        }
                    }
                }
                Spacer()
                Text("\(index + 1)/\(meal.stageList.count)").font(.headline)
            }.padding()
            NavigationLink(destination: PrintPreviewView(meal: meal), isActive: $printClicked) { EmptyView() }.navigationBarTitle(meal.name)
            NavigationLink(destination:
                ScrollView{
                    VStack { MealInfoPage(meal: meal, fullDetailed: true) }
            }, isActive: $infoClicked) { EmptyView() }.navigationBarTitle(meal.name)
        }.padding(.vertical)
        .toolbar {
            HStack {
                Button(action: {
                    infoClicked = true
                }) {
                    Image(systemName: "info.circle").imageScale(.large).foregroundColor(.accentColor)
                }
                Button(action: {
                    printClicked = true
                }) {
                    Image(systemName: "printer").imageScale(.large).foregroundColor(.accentColor)
                }
            }
        }
        .onAppear {
            oldNbGuests = meal.nbGuests
        }.sheet(isPresented: $vm.showShareSheet) {
            vm.pdfURL = nil
        } content: {
            if let pdfURL = vm.pdfURL {
                ShareSheet(urls: [pdfURL])
            }
        }
    }
    
    func updateMeal() {
        meal.stageList.forEach { stage in
            stage.ingredients.forEach { ingredient in
                ingredient.quantity = ingredient.quantity * meal.nbGuests / oldNbGuests
            }
        }
        MealDAO().updateOrAddMeal(meal: meal)
    }
    
    func printFiche() {
        exportPDF(content: { self }, filename: meal.name) { status, url in
            if let url = url, status {
                vm.pdfURL = url
                vm.showShareSheet.toggle()
            }
            else {
                print("PDF failed")
            }
        }
    }
    
    func leftClicked() {
        if index != 0 {
            index -= 1
        }
    }
    
    func rightClicked() {
        if index != meal.stageList.count - 1 {
            index += 1
        }
    }
    
    func setupAppearance() {
      UIPageControl.appearance().currentPageIndicatorTintColor = .black
      UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIActivityViewController
    var urls: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: urls, applicationActivities: nil)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
