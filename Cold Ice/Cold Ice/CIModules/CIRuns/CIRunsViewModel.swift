//
//  CIRunsViewModel.swift
//  Cold Ice
//
//

import SwiftUI

final class CIRunsViewModel: ObservableObject {
    @Published var runs: [Run] = [
        
    ] {
        didSet {
            saveAchievementsItem()
        }
    }
    
    @Published var tricks: [Trick] = [
        
    ] {
        didSet {
            saveTricks()
        }
    }
    
    private let userDefaultsAchievementsKey = "achievementsKeyCP1"
    private let userDefaultsTricksKey = "userDefaultsTricksKey1"
    
    init() {
        loadAchievementsItem()
        loadTricks()
    }
    
    func saveAchievementsItem() {
        if let encodedData = try? JSONEncoder().encode(runs) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsAchievementsKey)
        }
        
    }
    
    func loadAchievementsItem() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsAchievementsKey),
           let loadedItem = try? JSONDecoder().decode([Run].self, from: savedData) {
            runs = loadedItem
        } else {
            print("No saved data found")
        }
    }
    
    func saveTricks() {
        if let encodedData = try? JSONEncoder().encode(tricks) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsTricksKey)
        }
        
    }
    
    func loadTricks() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsTricksKey),
           let loadedItem = try? JSONDecoder().decode([Trick].self, from: savedData) {
            tricks = loadedItem
        } else {
            print("No saved data found")
        }
    }
    
    func add(_ run: Run) {
        runs.append(run)
    }
    
    func add(_ trick: Trick) {
        tricks.append(trick)
    }
    
    func edit(_ trick: Trick, status: TrickStatus, progress: Int, success: Int, notes: String) {
        guard let index = tricks.firstIndex(where: { $0.id == trick.id }) else { return }
        tricks[index].status = status
        tricks[index].progress = progress
        tricks[index].success = success
        tricks[index].notes = notes
    }
    
    func delete(_ run: Run) {
        if let index = runs.firstIndex(where: { $0.id == run.id }) {
            runs.remove(at: index)
        }
    }
    
}










