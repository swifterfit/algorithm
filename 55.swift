class Solution {
    func canJump(_ nums: [Int]) -> Bool {
        var maxReach = 0
        for i in 0..<nums.count {
            if i > maxReach { return false }  
            maxReach = max(maxReach, i + num[i])
        }
        return true
    }
}