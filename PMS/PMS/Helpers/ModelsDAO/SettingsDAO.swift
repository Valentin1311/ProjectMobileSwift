import Foundation
import FirebaseFirestore

class SettingsDAO {
    
    private let firestore = Firestore.firestore()
    
    func mapSettings(documents : [QueryDocumentSnapshot]) -> [SettingDTO] {
        return documents.map {
            (doc) -> SettingDTO in
            return self.jsonToSetting(doc: doc)
        }
    }
    
    func jsonToSetting(doc: QueryDocumentSnapshot) -> SettingDTO {
        return SettingDTO(id: doc.documentID, name: doc["name"] as? String ?? "", value: doc["value"] as? Double ?? 0)
    }
    
    func settingToJson(setting: SettingDTO) -> [String: Any] {
        var settingDictionnary: [String : Any] = [String : Any]()
        settingDictionnary["name"] = setting.name
        settingDictionnary["value"] = setting.value
        
        return settingDictionnary
    }
    
    func updateOrAddSetting(setting: SettingDTO) {
        let settingDictionnary = settingToJson(setting: setting)
        if let documentId = setting.id {
            do {
                try firestore.collection("Settings").document(documentId).setData(settingDictionnary)
            }
            catch {
              print(error)
            }
        }
        else {
            firestore.collection("Settings").addDocument(data: settingDictionnary)
        }
    }
    
    func deleteSetting(setting : SettingDTO) {
        if let documentId = setting.id {
            do {
                try firestore.collection("Settings").document(documentId).delete()
            }
            catch {
              print(error)
            }
        }
    }
    
}

