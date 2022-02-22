//
//  Meal.swift
//  PMS
//
//  Created by etud on 22/02/2022.
//  Copyright © 2022 	. All rights reserved.
//

import Foundation


class MealDTO : Identifiable {
    var id: String?
    var name: String
    var manager: String
    var category: String
    var nbGuests: Int
    var stageList: [StageDTO]
    var matS: String?
    var matD: String?
    var coefVenteHT: String?
    var coefVenteTTC: String?
    var coutHFluide: String?
    var coutHMoyen: String?

    init(id:String?, name: String, manager: String, category: String, nbGuests: Int, stageList: [StageDTO], matS: String?, matD: String?, coefVenteHT: String?, coefVenteTTC: String?, coutHFluide: String?, coutHMoyen: String?) {
        self.id = id
        self.name = name
        self.manager = manager
        self.category = category
        self.nbGuests = nbGuests
        self.stageList = stageList
        self.matS = matS
        self.matD = matD
        self.coefVenteHT = coefVenteHT
        self.coefVenteTTC = coefVenteTTC
        self.coutHFluide = coutHFluide
        self.coutHMoyen = coutHMoyen
    }
}
