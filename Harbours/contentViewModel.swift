//
//  contentViewModel.swift
//  Harbours
//
//  Created by naga vineel golla on 2/22/24.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var showingDimensionsSheet = false
    @Published var rows: Int = 0
    @Published var columns: Int = 0
    @Published var result: (path: [Int]?, cost: Int?) = (nil,nil)
    var matrixVals = [[Int]]()
    
    func initializeMatrix() {
        self.matrixVals = Array(repeating: Array(repeating: 0, count: columns), count: rows)
    }
    
    func Calculate() {
        self.result = findLowestCostPath(matrix: self.matrixVals)
    }
    
    func findLowestCostPath(matrix: [[Int]]) -> (path: [Int], cost: Int) {
        let rows = matrix.count
        let columns = matrix[0].count
        
        var minCost = Int.max
        var minPath = [Int]()
        
        func findPath(currentRow: Int, currentColumn: Int, currentCost: Int, path: [Int]) {
            // If reached the last column or cost exceeds 50, return
            if currentColumn == columns - 1 || currentCost >= 50 {
                if currentCost < minCost {
                    minCost = currentCost
                    minPath = path
                }
                return
            }
            
            // Define the possible directions to move (straight, up, down)
            let directions = [0, -1, 1]
            
            for direction in directions {
                let nextRow = (currentRow + direction + rows) % rows
                let nextColumn = currentColumn + 1
                
                // Calculate the cost of moving to the next cell
                let nextCost = currentCost + matrix[nextRow][nextColumn]
                
                // Recursive call to explore the next cell
                findPath(currentRow: nextRow, currentColumn: nextColumn, currentCost: nextCost, path: path + [nextRow])
            }
        }
        
        // Iterate over each cell in the first column to find the lowest cost path
        for i in 0..<rows {
            findPath(currentRow: i, currentColumn: 0, currentCost: matrix[i][0], path: [i])
        }
        
        return (minPath, minCost)
    }
}
