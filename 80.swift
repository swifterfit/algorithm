class Solution {
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        let count = nums.count
        if count <= 2 { return count }

        var slow = 2
        var fast = 2
        while fast < count {
            if nums[fast] != nums[slow - 2] {
                nums[slow] = nums[fast]
                slow += 1
            }
            fast += 1
        }
        return slow 
    }
}