import Foundation


class ModifSettingVM : ObservableObject, SettingDelegate {
    
    private var setting : SettingDTO
    private var settingsDAO = SettingsDAO()
    
    @Published var value : Double{
        didSet{
            setting.value = value
        }
    }
    
    @Published var name : String
    
    init(settingReceived : SettingDTO){
        setting = settingReceived
        name = setting.name
        value = setting.value
    }
    
    func valueChanged(newValue: Double) {
        if(setting.value != value){
            value = setting.value
        }
    }
    
    func userConfirmed(){
        settingsDAO.updateOrAddSetting(setting: setting)
    }
    
}
