/*
 215. 数组中的第K个最大元素
 
 题目描述：
 给定整数数组 nums 和整数 k，请返回数组中第 k 个最大的元素。
 请注意，你需要找的是数组排序后的第 k 个最大的元素，而不是第 k 个不同的元素。
 
 示例：
 输入: nums = [3,2,1,5,6,4], k = 2
 输出: 5
 
 输入: nums = [3,2,3,1,2,4,5,5,6], k = 4
 输出: 4
 */

import Foundation

class Solution {
    
    // 方法1：排序法 - 时间复杂度 O(nlogn)，空间复杂度 O(1)
    func findKthLargest(_ nums: [Int], _ k: Int) -> Int {
        let sortedNums = nums.sorted(by: >) // 降序排序
        return sortedNums[k - 1]
    }
    
    // 方法2：快速选择算法 - 平均时间复杂度 O(n)，最坏情况 O(n²)，空间复杂度 O(1)
    func findKthLargestQuickSelect(_ nums: [Int], _ k: Int) -> Int {
        var nums = nums
        return quickSelect(&nums, 0, nums.count - 1, k)
    }
    
    private func quickSelect(_ nums: inout [Int], _ left: Int, _ right: Int, _ k: Int) -> Int {
        if left == right {
            return nums[left]
        }
        
        let pivotIndex = partition(&nums, left, right)
        
        if pivotIndex == k - 1 {
            return nums[pivotIndex]
        } else if pivotIndex > k - 1 {
            return quickSelect(&nums, left, pivotIndex - 1, k)
        } else {
            return quickSelect(&nums, pivotIndex + 1, right, k)
        }
    }
    
    private func partition(_ nums: inout [Int], _ left: Int, _ right: Int) -> Int {
        let pivot = nums[right]
        var i = left
        
        for j in left..<right {
            if nums[j] >= pivot { // 降序排列，找第k大
                nums.swapAt(i, j)
                i += 1
            }
        }
        
        nums.swapAt(i, right)
        return i
    }
    
    // 方法3：堆排序 - 时间复杂度 O(nlogk)，空间复杂度 O(k)
    func findKthLargestHeap(_ nums: [Int], _ k: Int) -> Int {
        var minHeap = [Int]()
        
        for num in nums {
            if minHeap.count < k {
                minHeap.append(num)
                heapifyUp(&minHeap)
            } else if num > minHeap[0] {
                minHeap[0] = num
                heapifyDown(&minHeap, 0)
            }
        }
        
        return minHeap[0]
    }
    
    private func heapifyUp(_ heap: inout [Int]) {
        var index = heap.count - 1
        while index > 0 {
            let parentIndex = (index - 1) / 2
            if heap[index] < heap[parentIndex] {
                heap.swapAt(index, parentIndex)
                index = parentIndex
            } else {
                break
            }
        }
    }
    
    private func heapifyDown(_ heap: inout [Int], _ index: Int) {
        let n = heap.count
        var currentIndex = index
        
        while true {
            var smallestIndex = currentIndex
            let leftChildIndex = 2 * currentIndex + 1
            let rightChildIndex = 2 * currentIndex + 2
            
            if leftChildIndex < n && heap[leftChildIndex] < heap[smallestIndex] {
                smallestIndex = leftChildIndex
            }
            
            if rightChildIndex < n && heap[rightChildIndex] < heap[smallestIndex] {
                smallestIndex = rightChildIndex
            }
            
            if smallestIndex == currentIndex {
                break
            }
            
            heap.swapAt(currentIndex, smallestIndex)
            currentIndex = smallestIndex
        }
    }
}

// 测试代码
func testFindKthLargest() {
    let solution = Solution()
    
    // 测试用例1
    let nums1 = [3, 2, 1, 5, 6, 4]
    let k1 = 2
    let expected1 = 5
    
    print("测试用例1:")
    print("输入: nums = \(nums1), k = \(k1)")
    print("期望输出: \(expected1)")
    
    let result1_1 = solution.findKthLargest(nums1, k1)
    let result1_2 = solution.findKthLargestQuickSelect(nums1, k1)
    let result1_3 = solution.findKthLargestHeap(nums1, k1)
    
    print("排序法结果: \(result1_1) - \(result1_1 == expected1 ? "✓" : "✗")")
    print("快速选择结果: \(result1_2) - \(result1_2 == expected1 ? "✓" : "✗")")
    print("堆排序结果: \(result1_3) - \(result1_3 == expected1 ? "✓" : "✗")")
    print()
    
    // 测试用例2
    let nums2 = [3, 2, 3, 1, 2, 4, 5, 5, 6]
    let k2 = 4
    let expected2 = 4
    
    print("测试用例2:")
    print("输入: nums = \(nums2), k = \(k2)")
    print("期望输出: \(expected2)")
    
    let result2_1 = solution.findKthLargest(nums2, k2)
    let result2_2 = solution.findKthLargestQuickSelect(nums2, k2)
    let result2_3 = solution.findKthLargestHeap(nums2, k2)
    
    print("排序法结果: \(result2_1) - \(result2_1 == expected2 ? "✓" : "✗")")
    print("快速选择结果: \(result2_2) - \(result2_2 == expected2 ? "✓" : "✗")")
    print("堆排序结果: \(result2_3) - \(result2_3 == expected2 ? "✓" : "✗")")
    print()
    
    // 测试用例3
    let nums3 = [1]
    let k3 = 1
    let expected3 = 1
    
    print("测试用例3:")
    print("输入: nums = \(nums3), k = \(k3)")
    print("期望输出: \(expected3)")
    
    let result3_1 = solution.findKthLargest(nums3, k3)
    let result3_2 = solution.findKthLargestQuickSelect(nums3, k3)
    let result3_3 = solution.findKthLargestHeap(nums3, k3)
    
    print("排序法结果: \(result3_1) - \(result3_1 == expected3 ? "✓" : "✗")")
    print("快速选择结果: \(result3_2) - \(result3_2 == expected3 ? "✓" : "✗")")
    print("堆排序结果: \(result3_3) - \(result3_3 == expected3 ? "✓" : "✗")")
}

// 运行测试
testFindKthLargest()
