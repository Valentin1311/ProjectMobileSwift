import SwiftUI

struct SettingsView: View {
    
    @StateObject var vm = SettingsVM()
    @State var isModifClicked = false
    
    let customBlue = Color(red: 5/255, green: 105/255, blue: 164/255)
    
    var body: some View {
        ScrollView{
            VStack{
                Text("Paramètres généraux").frame(maxWidth : .infinity, minHeight : 35)
                    .font(.system(size : 20)).cornerRadius(0)
                    .background(.white).foregroundColor(customBlue)
                Spacer().frame(height : 10)
                VStack{
                    ForEach($vm.settings, id : \.id){ setting in
                        DetailledSettingView(settingReceived: setting.wrappedValue)
                        Spacer().frame(height : 40)
                    }
                }.padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                        .stroke(customBlue, lineWidth: 1))
            }.padding(10)
        }
    }
}
