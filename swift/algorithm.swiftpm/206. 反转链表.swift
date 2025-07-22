//
//  206. 反转链表.swift
//  algorithm
//
//  Created by 苏亮 on 22.7.25.
//

class ListNode {
    var val: Int
    var next: ListNode?
    init(val: Int, next: ListNode? = nil) {
        self.val = val
        self.next = next
    }
}

func reverseList(_ head: ListNode?) -> ListNode? {
    var prev: ListNode? = nil
    var curr = head
    while curr != nil {
        let next = curr?.next
        curr?.next = prev
        prev = curr
        curr = next
    }
    return prev
}
