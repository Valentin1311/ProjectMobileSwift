import SwiftUI

struct MealInfoPage: View {
    @State var meal: MealDTO
    var fullDetailed: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if fullDetailed {
                Text("Intitulé").font(.headline)
                HStack {
                    Text(meal.name)
                    Spacer()
                }.padding().overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 2))
                Text("Catégorie").font(.headline)
                HStack {
                    Text(meal.category)
                    Spacer()
                }.padding().overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 2))
                Text("Responsable").font(.headline)
                HStack {
                    Text(meal.manager)
                    Spacer()
                }.padding().overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 2))
                Text("Nombre de couverts").font(.headline)
                HStack {
                    Text(String(meal.nbGuests))
                    Spacer()
                }.padding().overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 2))
            }
            Text("Matériel de dressage").font(.headline)
            HStack {
                Text((meal.matD ?? "") == "" ? "Aucun matériel de dressage" : meal.matD!)
                Spacer()
            }.padding().overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 2))
            Text("Matériel spécifique").font(.headline)
            HStack {
                Text((meal.matD ?? "") == "" ? "Aucun matériel de dressage" : meal.matD!)
                Spacer()
            }.padding().overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 2))
            Text("Coûts horraire").font(.headline)
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Moyen : " + ((meal.coutHMoyen ?? 0) == 0 ? "Non renseigné" : "\(meal.coutHMoyen!) €/h"))
                    Spacer()
                }
                HStack {
                    Text("Fluide : " + ((meal.coutHFluide ?? 0) == 0 ? "Non renseigné" : "\(meal.coutHFluide!) €/h"))
                    Spacer()
                }
            }.padding().overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 2))
            Text("Coefficients de vente").font(.headline)
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Avec charges : " + ((meal.coefVenteTTC ?? 0) == 0 ? "Non renseigné" : "\(meal.coefVenteTTC!)"))
                    Spacer()
                }
                HStack {
                    Text("Sans charges : " + ((meal.coefVenteHT ?? 0) == 0 ? "Non renseigné" : "\(meal.coefVenteHT!)"))
                    Spacer()
                }
            }.padding().overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 2))
        }.padding()
    }
}
