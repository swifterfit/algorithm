class Solution {
    func majorityElement(_ nums: [Int]) -> Int {
        var map: [Int: Int] = [:]
        for num in nums {
            map[num, default: 0] += 1
        }
        for (key, value) in map {
            if value > nums.count / 2 {
                return key
            }
        }
        return 0
    }
}

class Solution2 {
    func majorityElement(_ nums: [Int]) -> Int {
        nums.sorted()[nums.count / 2]
    }
}