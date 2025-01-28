//
//  PRMatrix.swift
//  Watz
//
//  Created by Isaac Allport on 04/12/2024.
//

import Foundation
import Accelerate

// A Matrix

struct PRMatrix {
    public var rows: Int
    public var columns: Int
    public var asVector: [Double] = []
    
    internal init(rows m: Int, columns n: Int) {
        self.rows = m
        self.columns = n
        asVector = Array.init(repeating: 0, count: m*n)
    }
    
    public mutating func expand(toRows m: Int, columns n:Int) {
        if rows < m {
            asVector.append(contentsOf: Array.init(repeating: 0, count: columns*(m - rows)))
            self.rows = m
        }
        if columns < n {
            for row in (1...rows).reversed() {
                asVector.insert(contentsOf: Array.init(repeating: 0, count: (n-columns)), at: row*columns)
            }
            self.columns = n
        }
    }
    
    public subscript(row m: Int, column n: Int) -> Double {
        get {
            let positionIn1DMatrix = m*columns+n
            return asVector[positionIn1DMatrix]
        }
        set(newValue) {
            let positionIn1DMatrix = m*columns+n
            if positionIn1DMatrix == asVector.count {
                asVector.append(newValue)
            } else {
                asVector[positionIn1DMatrix] = newValue
            }
        }
    }
    
    public subscript(_ m: Int, _ n: Int) -> Double {
        get {
            self[row: m, column: n]
        }
        set(newValue) {
            self[row: m, column: n] = newValue
        }
    }
    
    
    // Matrix transpose

    public mutating func transpose() -> PRMatrix {
        var result = PRMatrix(rows: self.columns, columns: self.rows)
        var C = result.asVector
        let aStride = vDSP_Stride(1)
        let cStride = vDSP_Stride(1)
        let mLength = vDSP_Length(rows)
        let nLength = vDSP_Length(columns)
        vDSP_mtransD(self.asVector, aStride, &C, cStride, nLength, mLength)
        result.asVector = C
        return result
    }
    
    // Matrix Multiply
    
    public static func *(left: PRMatrix, right: PRMatrix) -> PRMatrix {
        assert(left.columns == right.rows, "There should be as many columns in matrix A (this matrix) as there are rows in matrix B (parameter matrix) to multiply. Matrix A has %lu columns and matrix B has %lu rows. left matrix colums: \(left.columns), right matrix rows\(right.rows)")
        
        let A = left.asVector
        let B = right.asVector
        var result = PRMatrix(rows: left.rows, columns: right.columns)
        var C = result.asVector
        
        let aStride = vDSP_Stride(1)
        let bStride = vDSP_Stride(1)
        let cStride = vDSP_Stride(1)

        vDSP_mmulD(
            A, aStride,
            B, bStride,
            &C, cStride,
            vDSP_Length(left.rows),
            vDSP_Length(result.columns),
            vDSP_Length(right.rows)
        )
        result.asVector = C
        return result
    }
}
