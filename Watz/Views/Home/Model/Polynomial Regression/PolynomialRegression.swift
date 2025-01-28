//
//  PolynomialRegression.swift
//  Watz
//
//  Created by Isaac Allport on 04/12/2024.
//

import Foundation
import Accelerate

public class PolynomialRegression {
    public static func regression(withPoints points: [CGPoint], degree: Int) -> [Double]? {
            guard degree > 0 else {
                return nil
            }
            guard points.count > 1 else {
                return nil
            }

            let A = createAMatrix(basedOnDegree: degree, columns: degree, withPoints: points)
            let b = createBVector(basedOnDegree: degree, withPoints: points)
            
            var coefficients:[Double] = []
            
            do {
                //solve A x = b
                coefficients = try solveLinearSystem(a: A.asVector,
                                      a_rowCount: A.rows,
                                      a_columnCount: A.columns,
                                      b: b.asVector,
                                      b_count: b.rows)
            } catch {
                fatalError("Unable to solve linear system.")
            }
                    
            return coefficients
        }
        
        static func createAMatrix(basedOnDegree degree: Int, columns: Int, withPoints points: [CGPoint]) -> PRMatrix {
            //create A Matrix
            var A = PRMatrix(rows: degree+1, columns: degree+1)
            
            var skip = 0
            for Arow in 0..<A.rows {
                for Acolumn in 0..<A.columns {
                    var sum: Double = 0
                    for point in points {
                        sum += pow(Double(point.x), Double(skip + Acolumn))
                    }
                    A[Arow,Acolumn] = sum
                }
                skip+=1
            }
            
            return A
        }
        
        static func createBVector(basedOnDegree degree: Int, withPoints points: [CGPoint]) -> PRMatrix {
            //create b Vector
            var b = PRMatrix(rows: degree+1, columns: 1)
            
            for bRow in 0..<b.rows {
                var sum:Double = 0
                for point in points {
                    sum +=  pow(Double(point.x), Double(bRow))  * Double(point.y)
                }
                b[bRow,0] = sum
            }
            return b
        }
        
        //solve A x = b
        static func solveLinearSystem(a: [Double],
                                      a_rowCount: Int, a_columnCount: Int,
                                      b: [Double],
                                      b_count: Int) throws -> [Double] {
            
            var a = a
            var b = b
            
            var info = Int32(0)
            
            // 1: Specify transpose.
            var trans = Int8("T".utf8.first!)
            
            // 2: Define constants.
            var m = __CLPK_integer(a_rowCount)
            var n = __CLPK_integer(a_columnCount)
            var lda = __CLPK_integer(a_rowCount)
            var nrhs = __CLPK_integer(1) // assumes `b` is a column matrix
            var ldb = __CLPK_integer(b_count)
            
            // 3: Workspace query.
            var workDimension = Double(0)
            var minusOne = Int32(-1)
            
            dgels_(&trans, &m, &n,
                   &nrhs,
                   &a, &lda,
                   &b, &ldb,
                   &workDimension, &minusOne,
                   &info)
            
            if info != 0 {
                throw LAPACKError.internalError
            }
            
            // 4: Create workspace.
            var lwork = Int32(workDimension)
            var workspace = [Double](repeating: 0,
                                     count: Int(workDimension))
            
            // 5: Solve linear system.
            dgels_(&trans, &m, &n,
                   &nrhs,
                   &a, &lda,
                   &b, &ldb,
                   &workspace, &lwork,
                   &info)
            
            if info < 0 {
                throw LAPACKError.parameterHasIllegalValue(parameterIndex: abs(Int(info)))
            } else if info > 0 {
                throw LAPACKError.diagonalElementOfTriangularFactorIsZero(index: Int(info))
            }

            return b
        }
        
        public static func calculateResidualSumOfSquares(ofPoints points: [CGPoint], withCoefficients coefficients: [Double]) -> Double? {
            guard points.count > 1 else {
                return nil
            }
            
            guard coefficients.count > 1 else {
                return nil
            }
                    
            let xValuesOfPoints = points.map { Double($0.x) }
            let yValuesOfPoints = points.map { $0.y }
                    
            let yPolynomialResults = vDSP.evaluatePolynomial(usingCoefficients: coefficients.reversed(), withVariables: xValuesOfPoints )
            
            var sumOfSquares: Double = 0
            
            for (yPoly, yPoint) in zip(yPolynomialResults, yValuesOfPoints) {
                sumOfSquares += Double(pow(yPoly - yPoint, 2))
            }
            
            return sumOfSquares
        }

        public enum LAPACKError: Swift.Error {
            case internalError
            case parameterHasIllegalValue(parameterIndex: Int)
            case diagonalElementOfTriangularFactorIsZero(index: Int)
        }
    
    public static func calculateMeanSquareError(ofPoints points: [CGPoint], withCoefficients coefficients: [Double]) -> Double? {
        guard points.count > 1 else {
            return nil
        }
        
        let xValuesOfPoints = points.map { Double($0.x) }
        let yValuesOfPoints = points.map { $0.y }
        
        // Evaluate the polynomial for each x-value
        let yPolynomialResults = vDSP.evaluatePolynomial(usingCoefficients: coefficients.reversed(), withVariables: xValuesOfPoints)
        
        var sumOfSquaredErrors: Double = 0
        
        // Compute the squared differences
        for (yPoly, yPoint) in zip(yPolynomialResults, yValuesOfPoints) {
            let error = yPoly - yPoint
            sumOfSquaredErrors += error * error
        }
        
        // MSE = sum of squared errors / number of points
        let mse = sumOfSquaredErrors / Double(points.count)
        return mse
    }
    
}
