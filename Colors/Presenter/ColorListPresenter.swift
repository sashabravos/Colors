//
//  ColorListPresenter.swift
//  Colors
//
//  Created by Александра Кострова on 05.09.2023.
//

import Foundation

protocol ColorListViewProtocol: AnyObject {
    func reloadTable()
        
    func showAlert(title: String, message: String)
}

protocol ColorListPresenterProtocol: AnyObject {
    func setView(_ view: ColorListViewProtocol)
    
    func numberOfSection() -> Int
    
    func numberOfRowInSection(_ section: Int) -> Int
    
    func titleForRow(at indexPath: IndexPath) -> String
    
    func heightForRowAt(indexPath: IndexPath) -> CGFloat
    
    func backgroundColorForCell(at indexPath: IndexPath) ->
    (red: CGFloat, green: CGFloat, blue: CGFloat)
    
    func didSelectColor(at indexPath: IndexPath)
    
    func getTitleForActionButton() -> String
    
    func actionButtonTapped()
}

final class ColorListPresenter: ColorListPresenterProtocol {
    
    private weak var view: ColorListViewProtocol?
    private var model: ColorListModel = ColorListModel()
    
    func setView(_ view: ColorListViewProtocol) {
        self.view = view
    }
    
    func numberOfSection() -> Int {
        return 1
    }
    
    func numberOfRowInSection(_ section: Int) -> Int {
        return model.colorList.count
    }
    
    func titleForRow(at indexPath: IndexPath) -> String {
        let color = model.colorList[indexPath.row]
        return color.name
    }
    
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func backgroundColorForCell(at indexPath: IndexPath) -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
        let color = model.colorList[indexPath.row]
        let resultColor: (red: CGFloat, green: CGFloat, blue: CGFloat) =
        (red: color.red, green: color.green, blue: color.blue)
        return resultColor
    }
    
    func didSelectColor(at indexPath: IndexPath) {
        let color = model.colorList[indexPath.row]
        showAlert(for: color)
    }
    
    func getTitleForActionButton() -> String {
        return "Add new color"
    }
    
    func actionButtonTapped() {
        addRandomColor()
    }
    
    private func showAlert(for model: ColorInfo) {
        let alertTitle: String = model.name
        let alertMessage: String = "Red: \(model.red), Green: \(model.green), Blue: \(model.blue)"
        
        view?.showAlert(title: alertTitle, message: alertMessage)
    }
    
    private func addRandomColor() {
        let newColor = ColorInfo(name: "Random Color",
                                 red: CGFloat.random(in: 0...1),
                                 green: CGFloat.random(in: 0...1),
                                 blue: CGFloat.random(in: 0...1))
        
        model.addColor(newColor)
        view?.reloadTable()
    }
}
