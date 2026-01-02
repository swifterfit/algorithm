class Solution {
    func jump(_ nums: [Int]) -> Int {
        var end = 0
        var maxPosition = 0
        var steps = 0
        for i in 0..<nums.count - 1 {
            maxPosition = max(maxPosition, i + nums[i])
            if i == end {
                end = maxPosition
                steps += 1
            }
        }
        return steps
    }
}