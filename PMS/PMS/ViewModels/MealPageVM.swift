import Foundation

class MealPageVM: ObservableObject {
    @Published var pdfURL: URL?
    @Published var showShareSheet: Bool = false
}
