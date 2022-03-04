//
//  MealPageVM.swift
//  PMS
//
//  Created by m1 on 03/03/2022.
//  Copyright © 2022 	. All rights reserved.
//

import Foundation

class MealPageVM: ObservableObject {
    @Published var pdfURL: URL?
    @Published var showShareSheet: Bool = false
}
