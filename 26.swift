class Solution {
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        let count = nums.count
        if count == 0 { return 0 }
        var slow = 1
        var fast = 1
        while fast < count {
            if nums[fast] != nums[fast - 1] {
                nums[slow] = nums[fast]
                slow += 1
            }
            fast += 1
        }
        return slow
    }
}