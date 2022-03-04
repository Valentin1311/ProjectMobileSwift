import SwiftUI

struct PrintPreviewView: View {
    @StateObject var vm = MealPageVM()
    @State var meal: MealDTO
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 10) {
                HStack(spacing: 4) {
                    Text(meal.name).font(.title3).lineLimit(1).truncationMode(.tail)
                    Text("(\(meal.category))").font(.title3).bold().lineLimit(1).truncationMode(.tail)
                }
                Text("Responsable : " + meal.manager).italic()
                Text(String(meal.nbGuests) + " couverts").font(.callout).padding(.bottom, 25)
                ForEach((0..<meal.stageList.count), id: \.self) { index in
                    VStack {
                        StageView(vm: StagePageVM(stage: meal.stageList[index]), stageIndex: index, editable: false)
                    }.padding(.vertical)
                    Rectangle().fill(.black).frame(width: .infinity, height: 2).padding(.horizontal, index != meal.stageList.count - 1 ? 100 : 30)
                }
                MealInfoPage(meal: meal, fullDetailed: false).padding(.top, 20)
            }.toolbar {
                ToolbarItem {
                    Button(action: {
                        printFiche()
                    }) {
                        Image(systemName: "arrow.down.doc").imageScale(.large).foregroundColor(.accentColor)
                    }
                }
            }.sheet(isPresented: $vm.showShareSheet) {
                vm.pdfURL = nil
            } content: {
                if let pdfURL = vm.pdfURL {
                    ShareSheet(urls: [pdfURL])
                }
            }.padding(.vertical)
        }
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
} 
