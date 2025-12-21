class Solution {
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        for i in 0..<n {
            nums1[m + i] = nums2[i]
        }
        nums1.sort()
    }
}

class Solution2 {
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        var p1 = 0
        var p2 = 0
        var sorted: [Int] = []
        while p1 < m || p2 < n {
            if p1 == m {
                sorted.append(nums2[p2])
                p2 += 1
            } else if p2 == n {
                sorted.append(nums1[p1])
                p1 += 1
            } else if nums1[p1] < nums2[p2] {
                sorted.append(nums1[p1])
                p1 += 1
            } else {
                sorted.append(nums2[p2])    
                p2 += 1
            }
        }
        nums1 = sorted
    }
}

class Solution3 {
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        var p1 = m - 1
        var p2 = n - 1
        var p = m + n - 1
        while p1 >= 0 && p2 >= 0 {
            if p1 == -1 {
                nums1[p] = nums2[p2]
                p2 -= 1
            } else if p2 == -1 {
                nums1[p] = nums1[p1]
                p1 -= 1
            } else if nums1[p1] > nums2[p2] {
                nums1[p] = nums1[p1]
                p1 -= 1
            } else {
                nums1[p] = nums2[p2]
                p2 -= 1
            }
            p -= 1
        }
    }
}