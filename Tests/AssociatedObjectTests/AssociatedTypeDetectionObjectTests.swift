//
//  AssociatedTypeDetectionObjectTests.swift
//
//
//  Created by p-x9 on 2024/01/18.
//
//

import XCTest
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import MacroTesting

#if canImport(AssociatedObjectPlugin)
@testable import AssociatedObjectPlugin
@testable import AssociatedObject

// MARK: - TypeDetection
// thanks: https://github.com/mlch911
final class AssociatedTypeDetectionObjectTests: XCTestCase {
    override func invokeTest() {
        withMacroTesting(
//            isRecording: true,
            macros: ["AssociatedObject": AssociatedObjectMacro.self]
        ) {
            super.invokeTest()
        }
    }
}

// MARK: - Simple Types
extension AssociatedTypeDetectionObjectTests {
    func testTypeDetectionInt() throws {
        assertMacro {
            """
            @AssociatedObject(.retain(.nonatomic))
            var int = 10
            """
        } expansion: {
            """
            var int = 10 {
                get {
                    if let value = getAssociatedObject(
                        self,
                        &Self.__associated_intKey
                    ) as? Swift.Int {
                        return value
                    } else {
                        let value: Swift.Int = 10
                        setAssociatedObject(
                            self,
                            &Self.__associated_intKey,
                            value,
                            .retain(.nonatomic)
                        )
                        return value
                    }
                }
                set {
                    setAssociatedObject(
                        self,
                        &Self.__associated_intKey,
                        newValue,
                        .retain(.nonatomic)
                    )
                }
            }

            @inline(never) static var __associated_intKey: UInt8 = 0
            """
        }
    }

    func testTypeDetectionDouble() throws {
        assertMacro {
            """
            @AssociatedObject(.retain(.nonatomic))
            var double = 10.0
            """
        } expansion: {
            """
            var double = 10.0 {
                get {
                    if let value = getAssociatedObject(
                        self,
                        &Self.__associated_doubleKey
                    ) as? Swift.Double {
                        return value
                    } else {
                        let value: Swift.Double = 10.0
                        setAssociatedObject(
                            self,
                            &Self.__associated_doubleKey,
                            value,
                            .retain(.nonatomic)
                        )
                        return value
                    }
                }
                set {
                    setAssociatedObject(
                        self,
                        &Self.__associated_doubleKey,
                        newValue,
                        .retain(.nonatomic)
                    )
                }
            }

            @inline(never) static var __associated_doubleKey: UInt8 = 0
            """
        }
    }

    func testTypeDetectionString() throws {
        assertMacro {
            """
            @AssociatedObject(.retain(.nonatomic))
            var string = "text"
            """
        } expansion: {
            """
            var string = "text" {
                get {
                    if let value = getAssociatedObject(
                        self,
                        &Self.__associated_stringKey
                    ) as? Swift.String {
                        return value
                    } else {
                        let value: Swift.String = "text"
                        setAssociatedObject(
                            self,
                            &Self.__associated_stringKey,
                            value,
                            .retain(.nonatomic)
                        )
                        return value
                    }
                }
                set {
                    setAssociatedObject(
                        self,
                        &Self.__associated_stringKey,
                        newValue,
                        .retain(.nonatomic)
                    )
                }
            }

            @inline(never) static var __associated_stringKey: UInt8 = 0
            """
        }
    }

    func testTypeDetectionBool() throws {
        assertMacro {
            """
            @AssociatedObject(.retain(.nonatomic))
            var bool = false
            """
        } expansion: {
            """
            var bool = false {
                get {
                    if let value = getAssociatedObject(
                        self,
                        &Self.__associated_boolKey
                    ) as? Swift.Bool {
                        return value
                    } else {
                        let value: Swift.Bool = false
                        setAssociatedObject(
                            self,
                            &Self.__associated_boolKey,
                            value,
                            .retain(.nonatomic)
                        )
                        return value
                    }
                }
                set {
                    setAssociatedObject(
                        self,
                        &Self.__associated_boolKey,
                        newValue,
                        .retain(.nonatomic)
                    )
                }
            }

            @inline(never) static var __associated_boolKey: UInt8 = 0
            """
        }
    }
}

// MARK: - Array
extension AssociatedTypeDetectionObjectTests {
    func testTypeDetectionIntArray() throws {
        assertMacro {
            """
            @AssociatedObject(.retain(.nonatomic))
            var intArray = [1, 2, 3]
            """
        } expansion: {
            """
            var intArray = [1, 2, 3] {
                get {
                    if let value = getAssociatedObject(
                        self,
                        &Self.__associated_intArrayKey
                    ) as? [Swift.Int] {
                        return value
                    } else {
                        let value: [Swift.Int] = [1, 2, 3]
                        setAssociatedObject(
                            self,
                            &Self.__associated_intArrayKey,
                            value,
                            .retain(.nonatomic)
                        )
                        return value
                    }
                }
                set {
                    setAssociatedObject(
                        self,
                        &Self.__associated_intArrayKey,
                        newValue,
                        .retain(.nonatomic)
                    )
                }
            }

            @inline(never) static var __associated_intArrayKey: UInt8 = 0
            """
        }
    }

    func testTypeDetectionDoubleArray() throws {
        assertMacro {
            """
            @AssociatedObject(.retain(.nonatomic))
            var doubleArray = [1.0, 2.0, 3.0]
            """
        } expansion: {
            """
            var doubleArray = [1.0, 2.0, 3.0] {
                get {
                    if let value = getAssociatedObject(
                        self,
                        &Self.__associated_doubleArrayKey
                    ) as? [Swift.Double] {
                        return value
                    } else {
                        let value: [Swift.Double] = [1.0, 2.0, 3.0]
                        setAssociatedObject(
                            self,
                            &Self.__associated_doubleArrayKey,
                            value,
                            .retain(.nonatomic)
                        )
                        return value
                    }
                }
                set {
                    setAssociatedObject(
                        self,
                        &Self.__associated_doubleArrayKey,
                        newValue,
                        .retain(.nonatomic)
                    )
                }
            }

            @inline(never) static var __associated_doubleArrayKey: UInt8 = 0
            """
        }
    }

    func testTypeDetectionIntAndDoubleArray() throws {
        assertMacro {
            """
            @AssociatedObject(.retain(.nonatomic))
            var doubleArray = [1, 1.0, 2, 2.0, 3, 3.0]
            """
        } expansion: {
            """
            var doubleArray = [1, 1.0, 2, 2.0, 3, 3.0] {
                get {
                    if let value = getAssociatedObject(
                        self,
                        &Self.__associated_doubleArrayKey
                    ) as? [Swift.Double] {
                        return value
                    } else {
                        let value: [Swift.Double] = [1, 1.0, 2, 2.0, 3, 3.0]
                        setAssociatedObject(
                            self,
                            &Self.__associated_doubleArrayKey,
                            value,
                            .retain(.nonatomic)
                        )
                        return value
                    }
                }
                set {
                    setAssociatedObject(
                        self,
                        &Self.__associated_doubleArrayKey,
                        newValue,
                        .retain(.nonatomic)
                    )
                }
            }

            @inline(never) static var __associated_doubleArrayKey: UInt8 = 0
            """
        }
    }

    func testTypeDetectionBoolArray() throws {
        assertMacro {
            """
            @AssociatedObject(.retain(.nonatomic))
            var boolArray = [true, false]
            """
        } expansion: {
            """
            var boolArray = [true, false] {
                get {
                    if let value = getAssociatedObject(
                        self,
                        &Self.__associated_boolArrayKey
                    ) as? [Swift.Bool] {
                        return value
                    } else {
                        let value: [Swift.Bool] = [true, false]
                        setAssociatedObject(
                            self,
                            &Self.__associated_boolArrayKey,
                            value,
                            .retain(.nonatomic)
                        )
                        return value
                    }
                }
                set {
                    setAssociatedObject(
                        self,
                        &Self.__associated_boolArrayKey,
                        newValue,
                        .retain(.nonatomic)
                    )
                }
            }

            @inline(never) static var __associated_boolArrayKey: UInt8 = 0
            """
        }
    }

    func testTypeDetectionStringArray() throws {
        assertMacro {
            """
            @AssociatedObject(.retain(.nonatomic))
            var stringArray = ["1.0", "2.0", "3.0"]
            """
        } expansion: {
            """
            var stringArray = ["1.0", "2.0", "3.0"] {
                get {
                    if let value = getAssociatedObject(
                        self,
                        &Self.__associated_stringArrayKey
                    ) as? [Swift.String] {
                        return value
                    } else {
                        let value: [Swift.String] = ["1.0", "2.0", "3.0"]
                        setAssociatedObject(
                            self,
                            &Self.__associated_stringArrayKey,
                            value,
                            .retain(.nonatomic)
                        )
                        return value
                    }
                }
                set {
                    setAssociatedObject(
                        self,
                        &Self.__associated_stringArrayKey,
                        newValue,
                        .retain(.nonatomic)
                    )
                }
            }

            @inline(never) static var __associated_stringArrayKey: UInt8 = 0
            """
        }
    }
}

// MARK: - Array with optional Elements
extension AssociatedTypeDetectionObjectTests {
    func testTypeDetectionOptionalIntArray() throws {
        assertMacro {
            """
            @AssociatedObject(.retain(.nonatomic))
            var optionalIntArray = [1, 1, nil, 2, 3, nil]
            """
        } expansion: {
            """
            var optionalIntArray = [1, 1, nil, 2, 3, nil] {
                get {
                    if let value = getAssociatedObject(
                        self,
                        &Self.__associated_optionalIntArrayKey
                    ) as? [Swift.Int?] {
                        return value
                    } else {
                        let value: [Swift.Int?] = [1, 1, nil, 2, 3, nil]
                        setAssociatedObject(
                            self,
                            &Self.__associated_optionalIntArrayKey,
                            value,
                            .retain(.nonatomic)
                        )
                        return value
                    }
                }
                set {
                    setAssociatedObject(
                        self,
                        &Self.__associated_optionalIntArrayKey,
                        newValue,
                        .retain(.nonatomic)
                    )
                }
            }

            @inline(never) static var __associated_optionalIntArrayKey: UInt8 = 0
            """
        }
    }

    func testTypeDetectionOptionalDoubleArray() throws {
        assertMacro {
            """
            @AssociatedObject(.retain(.nonatomic))
            var optionalDoubleArray = [1.0, 2.0, 3.0, nil]
            """
        } expansion: {
            """
            var optionalDoubleArray = [1.0, 2.0, 3.0, nil] {
                get {
                    if let value = getAssociatedObject(
                        self,
                        &Self.__associated_optionalDoubleArrayKey
                    ) as? [Swift.Double?] {
                        return value
                    } else {
                        let value: [Swift.Double?] = [1.0, 2.0, 3.0, nil]
                        setAssociatedObject(
                            self,
                            &Self.__associated_optionalDoubleArrayKey,
                            value,
                            .retain(.nonatomic)
                        )
                        return value
                    }
                }
                set {
                    setAssociatedObject(
                        self,
                        &Self.__associated_optionalDoubleArrayKey,
                        newValue,
                        .retain(.nonatomic)
                    )
                }
            }

            @inline(never) static var __associated_optionalDoubleArrayKey: UInt8 = 0
            """
        }
    }

    func testTypeDetectionOptionalIntAndDoubleArray() throws {
        assertMacro {
            """
            @AssociatedObject(.retain(.nonatomic))
            var doubleArray = [nil, 1, 1.0, nil, 2, 2.0, nil, 3, 3.0]
            """
        } expansion: {
            """
            var doubleArray = [nil, 1, 1.0, nil, 2, 2.0, nil, 3, 3.0] {
                get {
                    if let value = getAssociatedObject(
                        self,
                        &Self.__associated_doubleArrayKey
                    ) as? [Swift.Double?] {
                        return value
                    } else {
                        let value: [Swift.Double?] = [nil, 1, 1.0, nil, 2, 2.0, nil, 3, 3.0]
                        setAssociatedObject(
                            self,
                            &Self.__associated_doubleArrayKey,
                            value,
                            .retain(.nonatomic)
                        )
                        return value
                    }
                }
                set {
                    setAssociatedObject(
                        self,
                        &Self.__associated_doubleArrayKey,
                        newValue,
                        .retain(.nonatomic)
                    )
                }
            }

            @inline(never) static var __associated_doubleArrayKey: UInt8 = 0
            """
        }
    }


    func testTypeDetectionOptionalBoolArray() throws {
        assertMacro {
            """
            @AssociatedObject(.retain(.nonatomic))
            var optionalBoolArray = [true, false, nil]
            """
        } expansion: {
            """
            var optionalBoolArray = [true, false, nil] {
                get {
                    if let value = getAssociatedObject(
                        self,
                        &Self.__associated_optionalBoolArrayKey
                    ) as? [Swift.Bool?] {
                        return value
                    } else {
                        let value: [Swift.Bool?] = [true, false, nil]
                        setAssociatedObject(
                            self,
                            &Self.__associated_optionalBoolArrayKey,
                            value,
                            .retain(.nonatomic)
                        )
                        return value
                    }
                }
                set {
                    setAssociatedObject(
                        self,
                        &Self.__associated_optionalBoolArrayKey,
                        newValue,
                        .retain(.nonatomic)
                    )
                }
            }

            @inline(never) static var __associated_optionalBoolArrayKey: UInt8 = 0
            """
        }
    }

    func testTypeDetectionOptionalStringArray() throws {
        assertMacro {
            """
            @AssociatedObject(.retain(.nonatomic))
            var optionalStringArray = [nil, "true", "false", nil]
            """
        } expansion: {
            """
            var optionalStringArray = [nil, "true", "false", nil] {
                get {
                    if let value = getAssociatedObject(
                        self,
                        &Self.__associated_optionalStringArrayKey
                    ) as? [Swift.String?] {
                        return value
                    } else {
                        let value: [Swift.String?] = [nil, "true", "false", nil]
                        setAssociatedObject(
                            self,
                            &Self.__associated_optionalStringArrayKey,
                            value,
                            .retain(.nonatomic)
                        )
                        return value
                    }
                }
                set {
                    setAssociatedObject(
                        self,
                        &Self.__associated_optionalStringArrayKey,
                        newValue,
                        .retain(.nonatomic)
                    )
                }
            }

            @inline(never) static var __associated_optionalStringArrayKey: UInt8 = 0
            """
        }
    }
}

// MARK: - Dictionary
extension AssociatedTypeDetectionObjectTests {
    func testTypeDetectionStringDictionary() throws {
        assertMacro {
            """
            @AssociatedObject(.retain(.nonatomic))
            var dic = ["t": "a", "s": "b"]
            """
        } expansion: {
            """
            var dic = ["t": "a", "s": "b"] {
                get {
                    if let value = getAssociatedObject(
                        self,
                        &Self.__associated_dicKey
                    ) as? [Swift.String: Swift.String] {
                        return value
                    } else {
                        let value: [Swift.String: Swift.String] = ["t": "a", "s": "b"]
                        setAssociatedObject(
                            self,
                            &Self.__associated_dicKey,
                            value,
                            .retain(.nonatomic)
                        )
                        return value
                    }
                }
                set {
                    setAssociatedObject(
                        self,
                        &Self.__associated_dicKey,
                        newValue,
                        .retain(.nonatomic)
                    )
                }
            }

            @inline(never) static var __associated_dicKey: UInt8 = 0
            """
        }
    }

    func testTypeDetectionIntDictionary() throws {
        assertMacro {
            """
            @AssociatedObject(.retain(.nonatomic))
            var dic = [1: 3, 2: 4]
            """
        } expansion: {
            """
            var dic = [1: 3, 2: 4] {
                get {
                    if let value = getAssociatedObject(
                        self,
                        &Self.__associated_dicKey
                    ) as? [Swift.Int: Swift.Int] {
                        return value
                    } else {
                        let value: [Swift.Int: Swift.Int] = [1: 3, 2: 4]
                        setAssociatedObject(
                            self,
                            &Self.__associated_dicKey,
                            value,
                            .retain(.nonatomic)
                        )
                        return value
                    }
                }
                set {
                    setAssociatedObject(
                        self,
                        &Self.__associated_dicKey,
                        newValue,
                        .retain(.nonatomic)
                    )
                }
            }

            @inline(never) static var __associated_dicKey: UInt8 = 0
            """
        }
    }

    func testTypeDetectionDoubleDictionary() throws {
        assertMacro {
            """
            @AssociatedObject(.retain(.nonatomic))
            var dic = [1.0: 3.0, 2.0: 4.0]
            """
        } expansion: {
            """
            var dic = [1.0: 3.0, 2.0: 4.0] {
                get {
                    if let value = getAssociatedObject(
                        self,
                        &Self.__associated_dicKey
                    ) as? [Swift.Double: Swift.Double] {
                        return value
                    } else {
                        let value: [Swift.Double: Swift.Double] = [1.0: 3.0, 2.0: 4.0]
                        setAssociatedObject(
                            self,
                            &Self.__associated_dicKey,
                            value,
                            .retain(.nonatomic)
                        )
                        return value
                    }
                }
                set {
                    setAssociatedObject(
                        self,
                        &Self.__associated_dicKey,
                        newValue,
                        .retain(.nonatomic)
                    )
                }
            }

            @inline(never) static var __associated_dicKey: UInt8 = 0
            """
        }
    }
}


// MARK: - Other
extension AssociatedTypeDetectionObjectTests {
    func testTypeDetection2DimensionDoubleArray() throws {
        assertMacro {
            """
            @AssociatedObject(.retain(.nonatomic))
            var array = [[1.0], [2.0], [3.0, 4.0]]
            """
        } expansion: {
            """
            var array = [[1.0], [2.0], [3.0, 4.0]] {
                get {
                    if let value = getAssociatedObject(
                        self,
                        &Self.__associated_arrayKey
                    ) as? [[Swift.Double]] {
                        return value
                    } else {
                        let value: [[Swift.Double]] = [[1.0], [2.0], [3.0, 4.0]]
                        setAssociatedObject(
                            self,
                            &Self.__associated_arrayKey,
                            value,
                            .retain(.nonatomic)
                        )
                        return value
                    }
                }
                set {
                    setAssociatedObject(
                        self,
                        &Self.__associated_arrayKey,
                        newValue,
                        .retain(.nonatomic)
                    )
                }
            }

            @inline(never) static var __associated_arrayKey: UInt8 = 0
            """
        }
    }
}
#endif
