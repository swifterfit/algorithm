class Solution {
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var left = 0
        for right in 0..<nums.count {
            if nums[right] != val {
                nums[left] = nums[right]
                left += 1
            }
        }
        return left
    }
}

class Solution2 {
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var left = 0
        
        var right = nums.count - 1
        while left <= right {
            if nums[left] == val {
                nums[left] = nums[right]
                right -= 1
            } else {
                left += 1
            }
        }
        return left
    }
}