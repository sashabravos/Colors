//
//  ColorListModel.swift
//  Colors
//
//  Created by Александра Кострова on 05.09.2023.
//

import Foundation

struct ColorListModel {
    
    var colorList: [ColorInfo] {
        return privateColorList
    }
    private var privateColorList: [ColorInfo] = []
    
    init() {
        setupDefaultColors()
    }
    
    private mutating func setupDefaultColors() {
        let modelRed = ColorInfo(name: "Custom Red", red: 1, green: 0, blue: 0)
        let modelGreen = ColorInfo(name: "Custom Green", red: 0, green: 1, blue: 0)
        let modelBlue = ColorInfo(name: "Custom Blue", red: 0, green: 0, blue: 1)
        let modelYellow = ColorInfo(name: "Custom Yellow", red: 1, green: 1, blue: 0)

        privateColorList = ([modelRed, modelGreen, modelBlue, modelYellow])
    }
    
    mutating func addColor(_ color: ColorInfo) {
        self.privateColorList.append(color)
    }
}
