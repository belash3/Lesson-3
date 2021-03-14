//
//  main.swift
//  Lesson3
//
//  Created by Сергей Беляков on 10.03.2021.
//

import Foundation

// Задание 1: Описать несколько структур – любой легковой автомобиль SportCar и любой грузовик TrunkCar.

enum EngineState: String {
    case running = "запущен"
    case stopped = "заглушен"
}

enum WindowState: String {
    case open = "открыты"
    case closed = "закрыты"
}
enum TrailerState: String {
    case installed = "установлен"
    case uninstalled = "снят"
    }

struct SportCar {
    let model: String
    let year: Int
    let maxTrunkVolume: Double
    var engine: EngineState
    var windowState: WindowState
    var usedTrunkVolume: Double
    
    
    mutating func windowState(_ windowState: WindowState) {
        self.windowState = windowState
        print("Окна были \(windowState.rawValue)")
    }

    mutating func engineState(_ engineState: EngineState) {
        engine = engineState
        print("Двигатель был \(engine.rawValue)")
    }
    
    func printTrunkLoad() {
        print("Загрузка багажника: \(usedTrunkVolume) из \(maxTrunkVolume)")
    }
    
    mutating func trunkLoad(_ cargo: Double) {
        print("---------------------------------")
        print("Пытаемся загрузить груз объемом \(cargo)")
        if (usedTrunkVolume + cargo) <= maxTrunkVolume {
            usedTrunkVolume += cargo
            print("Груз загружен.")
            printTrunkLoad()
        }
        else if (usedTrunkVolume + cargo) > maxTrunkVolume {
            print("Недостаточно места. Свободно только \(maxTrunkVolume - usedTrunkVolume). Выгрузите \(cargo - (maxTrunkVolume - usedTrunkVolume))")
            
            printTrunkLoad()
        }
    }
    mutating func trunkUnload(_ cargo: Double) {
        print("---------------------------------")
        print("Выгружаем груз объемом \(cargo)")
        if (usedTrunkVolume - cargo) >= 0 {
            usedTrunkVolume -= cargo
            print("Груз выгружен.")
            printTrunkLoad()
        }
        else if (usedTrunkVolume - cargo) < 0 {
            print("Вы пытаетесь выгрузить больше груза, чем есть в багажнике. Будет выгружен весь оставшийся груз: \(usedTrunkVolume)")
            usedTrunkVolume = 0
            printTrunkLoad()
        }
    }
    
    func printCarInfo() {
        print("---------------------------------")
        print("Марка: \(model)")
        print("Год выпуска: \(year)")
        print("Объем багажника: \(maxTrunkVolume)")
        print("Двигатель: \(engine.rawValue)")
        print("Окна: \(windowState.rawValue)")
        print("Загрузка багажника: \(usedTrunkVolume) из \(maxTrunkVolume)")
        print("---------------------------------")
    }
}




var toyotaSupra = SportCar(model: "Toyota Supra", year: 2005, maxTrunkVolume: 500, engine: .stopped, windowState: .closed, usedTrunkVolume: 0.0)

toyotaSupra.printCarInfo()
toyotaSupra.engineState(.running)
toyotaSupra.windowState(.open)
toyotaSupra.trunkLoad(150)
toyotaSupra.trunkLoad(351)
toyotaSupra.trunkUnload(100)
toyotaSupra.trunkUnload(60)
toyotaSupra.printCarInfo()

var nissanSkyline = SportCar(model: "Nissan Skyline", year: 2009, maxTrunkVolume: 600, engine: .running, windowState: .open, usedTrunkVolume: 500)

nissanSkyline.printCarInfo()

nissanSkyline.windowState(.closed)
nissanSkyline.engineState(.stopped)
nissanSkyline.trunkLoad(150)
nissanSkyline.trunkUnload(50)
nissanSkyline.trunkLoad(150)

nissanSkyline.printCarInfo()

// ----------------------------------------------

struct TrunkCar {
    let model: String
    let year: Int
    let carTrunkVolume: Double
    var totalTrunkVolume: Double {
        get {
            if trailerState == .installed {
                return carTrunkVolume + trailerVolume
            } else { return carTrunkVolume }
            
        }
    }
    var engine: EngineState
    var windowState: WindowState
    var usedTrunkVolume: Double
    var trailerState: TrailerState
    var trailerVolume: Double
    


    
    mutating func trailerState(_ trailer: TrailerState) {
        trailerState = trailer
        print("Прицеп был \(trailerState.rawValue)")
        print("Теперь объем кузова: \(totalTrunkVolume)")

    }
    mutating func windowState(_ windowState: WindowState) {
        self.windowState = windowState
        print("Окна были \(windowState.rawValue)")
    }

    mutating func engineState(_ engineState: EngineState) {
        engine = engineState
        print("Двигатель был \(engine.rawValue)")
    }
    
    func printTrunkLoad() {
        print("Загрузка багажника: \(usedTrunkVolume) из \(totalTrunkVolume)")
        print("Прицеп  сейчас \(trailerState.rawValue)")
        
        if usedTrunkVolume <= carTrunkVolume && trailerState == .installed {
            print("Если не планируете добавлять груз, прицеп можно отсоединить, так как объема основного кузова достаточно для текущего груза")
        }
    }
    
    mutating func trunkLoad(_ cargo: Double) {
        print("---------------------------------")
        print("Пытаемся загрузить груз объемом \(cargo)")
        if (usedTrunkVolume + cargo) <= totalTrunkVolume {
            usedTrunkVolume += cargo
            print("Груз загружен.")
            printTrunkLoad()
        }
        else if (usedTrunkVolume + cargo) > totalTrunkVolume && trailerState == .uninstalled {
            print("Недостаточно места. Свободно только \(totalTrunkVolume - usedTrunkVolume). Выгрузите \(cargo - (totalTrunkVolume - usedTrunkVolume)), или установите прицеп")
            
            printTrunkLoad()
        } else if (usedTrunkVolume + cargo) > totalTrunkVolume && trailerState == .installed {
            print("Недостаточно места. Свободно только \(totalTrunkVolume - usedTrunkVolume). Выгрузите \(cargo - (totalTrunkVolume - usedTrunkVolume))")
            
            printTrunkLoad() }
    }
    
    mutating func trunkUnload(_ cargo: Double) {
        print("---------------------------------")
        print("Выгружаем груз объемом \(cargo)")
        if (usedTrunkVolume - cargo) >= 0 {
            usedTrunkVolume -= cargo
            print("Груз выгружен.")
            printTrunkLoad()
        }
        else if (usedTrunkVolume - cargo) < 0 {
            print("Вы пытаетесь выгрузить больше груза, чем есть в багажнике. Будет выгружен весь оставшийся груз: \(usedTrunkVolume)")
            usedTrunkVolume = 0
            printTrunkLoad()
        }
    }
    func printCarInfo() {
        print("---------------------------------")
        print("Марка: \(model)")
        print("Год выпуска: \(year)")
        print("Объем основного кузова: \(carTrunkVolume)")
        print("Прицеп: \(trailerState.rawValue)")
        print("Объем прицепа: \(trailerVolume)")
        print("Общий объем кузова: \(totalTrunkVolume)")
        print("Двигатель: \(engine.rawValue)")
        print("Окна: \(windowState.rawValue)")
        print("Загрузка кузова: \(usedTrunkVolume) из \(totalTrunkVolume)")
        print("---------------------------------")
    }

}



var kamaz = TrunkCar(model: "Kamaz", year: 1980, carTrunkVolume: 1000, engine: .running, windowState: .open, usedTrunkVolume: 300, trailerState: .uninstalled, trailerVolume: 1500)
kamaz.printCarInfo()
kamaz.trunkLoad(1500)
kamaz.trailerState(.installed)
kamaz.trunkLoad(1500)
kamaz.trunkUnload(800)
kamaz.trailerState(.uninstalled)
kamaz.printCarInfo()
