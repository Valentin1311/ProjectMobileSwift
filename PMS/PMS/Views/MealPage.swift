//
//  MealPage.swift
//  PMS
//
//  Created by m1 on 22/02/2022.
//  Copyright © 2022 	. All rights reserved.
//

import SwiftUI

struct MealPage: View {
    @State private var index = 0
    @Binding var meal: MealDTO
    @State private var editClicked = false
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .firstTextBaseline, spacing: 10) {
                Text(meal.name).font(.title2).lineLimit(1)
                Spacer()
                Button(action: {
                    printFiche()
                }) {
                    Image(systemName: "printer").imageScale(.large).foregroundColor(.accentColor)
                }
            }.padding()
            TabView(selection: $index) {
                ForEach((0..<meal.stageList.count), id: \.self) { index in
                    StageView(stage: meal.stageList[index])
                 }
             }
             .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            Spacer()
            HStack(alignment: .bottom, spacing: 10) {
                HStack() {
                    Image(systemName: "fork.knife").imageScale(.large).foregroundColor(.accentColor)
                    Text("\(meal.nbGuests)")
                    if editClicked {
                        Stepper("", onIncrement: { meal.nbGuests += 1 }, onDecrement: { meal.nbGuests -= 1}).labelsHidden()
                        Button(action: { editClicked = false }) {
                            Image(systemName: "checkmark").imageScale(.large).foregroundColor(.accentColor)
                        }
                    }
                    else {
                        Button(action: { editClicked = true }) {
                            Image(systemName: "pencil").imageScale(.large).foregroundColor(.accentColor)
                        }
                    }
                }
                Spacer()
                VStack(alignment: .center, spacing: 5) {
                    Text("\(index + 1)/\(meal.stageList.count)").font(.caption)
                    HStack(alignment: .center, spacing: 1) {
                        Button(action: {
                            leftClicked()
                        }) {
                            Image(systemName: "arrow.left").imageScale(.large).foregroundColor(.accentColor).padding(4).overlay(Circle().stroke(Color.black, lineWidth: 2)).disabled(index == 0)
                        }
                        Button(action: {
                            rightClicked()
                        }) {
                            Image(systemName: "arrow.right").imageScale(.large).foregroundColor(.accentColor).padding(4).overlay(Circle().stroke(Color.black, lineWidth: 2)).disabled(index == meal.stageList.count - 1)
                        }
                    }
                }
            }.padding()
        }
    }
    
    func printFiche() {
        
    }
    
    func leftClicked() {
        if index != 0 {
            index -= 1
        }
    }
    
    func rightClicked() {
        if index != meal.stageList.count - 1 {
            index += 1
        }
    }
} 
