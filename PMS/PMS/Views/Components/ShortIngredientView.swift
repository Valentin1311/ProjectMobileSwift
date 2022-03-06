import SwiftUI

struct ShortIngredientView: View {
    @Binding var ingredient : IngredientDTO
    let customBlue = Color(red: 5/255, green: 105/255, blue: 164/255)
    let customGreen = Color(red: 0/255, green: 100/255, blue: 0/255)
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 10){
                Text(ingredient.name).bold()
                HStack{
                    Text(ingredient.category)
                        .foregroundColor(customBlue)
                        .font(.system(size: 12))
                        .padding(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                            .stroke(customBlue, lineWidth: 0.5))
                    Text(ingredient.price)
                        .foregroundColor(customBlue)
                        .font(.system(size: 10))
                        .padding(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                            .stroke(customBlue, lineWidth: 0.5))
                }
                if(ingredient.allergenCategory != nil) {
                    HStack{
                        Text("Allergène(s) :").italic().foregroundColor(.gray).font(.system(size : 12)).lineLimit(1)
                        Text(ingredient.allergenCategory as! String).italic().foregroundColor(.gray).font(.system(size : 12)).lineLimit(1)
                    }
                }
            }
            Spacer()
            ZStack {
                if(ingredient.stock > 0) {
                    Circle()
                        .strokeBorder(customGreen,lineWidth: 1)
                        .background(.white)
                    VStack(alignment : .center, spacing: 10){
                        Text(String(ingredient.stock)+" "+String(ingredient.unit)).font(.system(size: 12.5, weight: .bold)).lineLimit(1).foregroundColor(customGreen)
                        Text("En stock").font(.system(size: 12.5)).lineLimit(1).foregroundColor(customGreen)
                    }
                }
                else{
                    Circle()
                        .strokeBorder(Color.red,lineWidth: 1)
                        .background(.white)
                    VStack(alignment : .center, spacing: 10){
                        HStack {
                            Text(String(ingredient.stock)).font(.system(size: 12.5, weight: .bold)).lineLimit(1).foregroundColor(.red)
                            Text(String(ingredient.unit)).font(.system(size: 12.5, weight: .bold)).lineLimit(1).foregroundColor(.red)
                        }
                        Text("En stock").font(.system(size: 12.5)).lineLimit(1).foregroundColor(.red)
                    }
                }
            }.frame(width: 80, height: 80, alignment: .center)
            
        }.frame(height: 125)
    }
}
