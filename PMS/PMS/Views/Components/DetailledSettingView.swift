import SwiftUI

struct DetailledSettingView: View {
    
    @ObservedObject var vm : ModifSettingVM
    @State var editClicked = false
    @State var showConfirm = false
    
    let formatter : NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    init(settingReceived : SettingDTO){
        vm = ModifSettingVM(settingReceived: settingReceived)
    }
    
    var body: some View {
        VStack(alignment : .center){
            Text(vm.name).font(.callout).multilineTextAlignment(.center)
                HStack{
                    if(editClicked){
                        TextField("Ex. 12", value : $vm.value, formatter: formatter)
                            .padding()
                            .frame(width : 150)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 2))
                            .disabled(!editClicked)
                        Button(action : {
                            vm.userConfirmed()
                            editClicked = false
                            showConfirm = true
                        }){
                            Image(systemName: "checkmark.circle.fill").imageScale(.large)
                        }
                    }
                    else{
                        TextField("Ex. 12", value : $vm.value, formatter: formatter)
                            .padding()
                            .frame(width : 150)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 2))
                            .disabled(!editClicked)
                        Button(action : {
                            editClicked = true
                        }){
                            Image(systemName: "pencil").imageScale(.large)
                        }
                    }
                }
            }.alert(isPresented : $showConfirm) {
                Alert(title: Text("Confirmation"), message: Text("Modification effectu??e avec succ??s"))}
    }
}

