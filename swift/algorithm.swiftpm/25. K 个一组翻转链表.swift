/*
 25. K 个一组翻转链表
 
 题目描述：
 给你链表的头节点 head ，每 k 个节点一组进行翻转，请你返回修改后的链表。
 k 是一个正整数，它的值小于或等于链表的长度。如果节点总数不是 k 的整数倍，那么请将最后剩余的节点保持原有顺序。
 
 你不能只是单纯的改变节点内部的值，而是需要实际进行节点交换。
 
 示例：
 输入: head = [1,2,3,4,5], k = 2
 输出: [2,1,4,3,5]
 
 输入: head = [1,2,3,4,5], k = 3
 输出: [3,2,1,4,5]
 */

import Foundation

// 定义链表节点
public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class Solution {
    
    // 方法1：迭代法 - 时间复杂度 O(n)，空间复杂度 O(1)
    func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
        guard head != nil && k > 1 else { return head }
        
        let dummy = ListNode(0, head)
        var prev = dummy
        var current = head
        
        while current != nil {
            // 检查是否有足够的节点进行翻转
            var count = 0
            var temp = current
            while temp != nil && count < k {
                temp = temp?.next
                count += 1
            }
            
            if count < k {
                break // 剩余节点不足k个，保持原顺序
            }
            
            // 翻转当前组的k个节点
            let (newHead, newTail) = reverseKNodes(current, k)
            
            // 连接翻转后的部分
            prev.next = newHead
            current?.next = temp // 连接下一组
            
            // 更新指针
            prev = current!
            current = temp
        }
        
        return dummy.next
    }
    
    // 翻转k个节点，返回新的头尾节点
    private func reverseKNodes(_ head: ListNode?, _ k: Int) -> (ListNode?, ListNode?) {
        var prev: ListNode? = nil
        var current = head
        var next: ListNode? = nil
        var count = 0
        
        while current != nil && count < k {
            next = current?.next
            current?.next = prev
            prev = current
            current = next
            count += 1
        }
        
        return (prev, head) // prev是新的头，head是新的尾
    }
    
    // 方法2：递归法 - 时间复杂度 O(n)，空间复杂度 O(n/k) 递归栈深度
    func reverseKGroupRecursive(_ head: ListNode?, _ k: Int) -> ListNode? {
        guard head != nil && k > 1 else { return head }
        
        // 检查是否有足够的节点
        var count = 0
        var current = head
        while current != nil && count < k {
            current = current?.next
            count += 1
        }
        
        if count < k {
            return head // 不足k个，直接返回
        }
        
        // 翻转前k个节点
        var prev: ListNode? = nil
        current = head
        count = 0
        
        while current != nil && count < k {
            let next = current?.next
            current?.next = prev
            prev = current
            current = next
            count += 1
        }
        
        // 递归处理剩余部分
        head?.next = reverseKGroupRecursive(current, k)
        
        return prev
    }
    
    // 方法3：使用栈 - 时间复杂度 O(n)，空间复杂度 O(k)
    func reverseKGroupStack(_ head: ListNode?, _ k: Int) -> ListNode? {
        guard head != nil && k > 1 else { return head }
        
        let dummy = ListNode(0, head)
        var prev = dummy
        var current = head
        
        while current != nil {
            var stack = [ListNode]()
            var temp = current
            var count = 0
            
            // 将k个节点压入栈中
            while temp != nil && count < k {
                stack.append(temp!)
                temp = temp?.next
                count += 1
            }
            
            if count < k {
                break // 不足k个，保持原顺序
            }
            
            // 从栈中弹出节点，实现翻转
            while !stack.isEmpty {
                prev.next = stack.removeLast()
                prev = prev.next!
            }
            
            prev.next = temp // 连接下一组
            current = temp
        }
        
        return dummy.next
    }
}

// 辅助函数：创建链表
func createLinkedList(_ values: [Int]) -> ListNode? {
    guard !values.isEmpty else { return nil }
    
    let head = ListNode(values[0])
    var current = head
    
    for i in 1..<values.count {
        current.next = ListNode(values[i])
        current = current.next!
    }
    
    return head
}

// 辅助函数：打印链表
func printLinkedList(_ head: ListNode?) {
    var current = head
    var result = [Int]()
    
    while current != nil {
        result.append(current!.val)
        current = current?.next
    }
    
    print(result)
}

// 测试代码
func testReverseKGroup() {
    let solution = Solution()
    
    // 测试用例1
    print("测试用例1:")
    let head1 = createLinkedList([1, 2, 3, 4, 5])
    let k1 = 2
    let expected1 = [2, 1, 4, 3, 5]
    
    print("输入: head = [1,2,3,4,5], k = \(k1)")
    print("期望输出: \(expected1)")
    
    let result1_1 = solution.reverseKGroup(head1, k1)
    let result1_2 = solution.reverseKGroupRecursive(createLinkedList([1, 2, 3, 4, 5]), k1)
    let result1_3 = solution.reverseKGroupStack(createLinkedList([1, 2, 3, 4, 5]), k1)
    
    print("迭代法结果: ", terminator: "")
    printLinkedList(result1_1)
    print("递归法结果: ", terminator: "")
    printLinkedList(result1_2)
    print("栈方法结果: ", terminator: "")
    printLinkedList(result1_3)
    print()
    
    // 测试用例2
    print("测试用例2:")
    let head2 = createLinkedList([1, 2, 3, 4, 5])
    let k2 = 3
    let expected2 = [3, 2, 1, 4, 5]
    
    print("输入: head = [1,2,3,4,5], k = \(k2)")
    print("期望输出: \(expected2)")
    
    let result2_1 = solution.reverseKGroup(head2, k2)
    let result2_2 = solution.reverseKGroupRecursive(createLinkedList([1, 2, 3, 4, 5]), k2)
    let result2_3 = solution.reverseKGroupStack(createLinkedList([1, 2, 3, 4, 5]), k2)
    
    print("迭代法结果: ", terminator: "")
    printLinkedList(result2_1)
    print("递归法结果: ", terminator: "")
    printLinkedList(result2_2)
    print("栈方法结果: ", terminator: "")
    printLinkedList(result2_3)
    print()
    
    // 测试用例3
    print("测试用例3:")
    let head3 = createLinkedList([1, 2, 3, 4, 5])
    let k3 = 1
    let expected3 = [1, 2, 3, 4, 5]
    
    print("输入: head = [1,2,3,4,5], k = \(k3)")
    print("期望输出: \(expected3)")
    
    let result3_1 = solution.reverseKGroup(head3, k3)
    let result3_2 = solution.reverseKGroupRecursive(createLinkedList([1, 2, 3, 4, 5]), k3)
    let result3_3 = solution.reverseKGroupStack(createLinkedList([1, 2, 3, 4, 5]), k3)
    
    print("迭代法结果: ", terminator: "")
    printLinkedList(result3_1)
    print("递归法结果: ", terminator: "")
    printLinkedList(result3_2)
    print("栈方法结果: ", terminator: "")
    printLinkedList(result3_3)
    print()
    
    // 测试用例4
    print("测试用例4:")
    let head4 = createLinkedList([1])
    let k4 = 1
    let expected4 = [1]
    
    print("输入: head = [1], k = \(k4)")
    print("期望输出: \(expected4)")
    
    let result4_1 = solution.reverseKGroup(head4, k4)
    let result4_2 = solution.reverseKGroupRecursive(createLinkedList([1]), k4)
    let result4_3 = solution.reverseKGroupStack(createLinkedList([1]), k4)
    
    print("迭代法结果: ", terminator: "")
    printLinkedList(result4_1)
    print("递归法结果: ", terminator: "")
    printLinkedList(result4_2)
    print("栈方法结果: ", terminator: "")
    printLinkedList(result4_3)
}

// 运行测试
testReverseKGroup()
