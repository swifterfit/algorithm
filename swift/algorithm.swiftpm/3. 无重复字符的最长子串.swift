//
//  Untitled.swift
//  algorithm
//
//  Created by Emir on 21.7.25.
//
import Foundation

func lengthOfLongestSubstring(_ s: String) -> Int {
    var maxLength = 0
    var startIndex = 0
    var charIndexMap = [Character: Int]()
    
    for (endIndex, char) in s.enumerated() {
        if let prevIndex = charIndexMap[char], prevIndex >= startIndex {
            startIndex = prevIndex + 1
        }
        charIndexMap[char] = endIndex
        maxLength = max(maxLength, endIndex - startIndex + 1)
    }
    return maxLength
}
