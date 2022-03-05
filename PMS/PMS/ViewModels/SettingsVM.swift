import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine


class SettingsVM : ObservableObject{
    
    @Published var settings: [SettingDTO] = []
    
    private let firestore = Firestore.firestore()
    private var settingDAO = SettingsDAO()
    var data : QuerySnapshot?
    
    init() {
        self.fetchSettings()
    }
    
    func fetchSettings() {
       firestore.collection("Settings").addSnapshotListener{ (data, error) in
         guard let documents = data?.documents else {
                return // no documents
         }
          self.settings = self.settingDAO.mapSettings(documents: documents)
       }
    }
}
