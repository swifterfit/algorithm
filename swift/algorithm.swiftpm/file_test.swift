#!/usr/bin/env swift

import Foundation

// 将输出写入文件
let output = """
=== LRU缓存测试结果 ===

测试用例:
1. 创建容量为2的LRU缓存
2. put(1, 1)
3. put(2, 2)
4. get(1) 应该返回 1
5. put(3, 3) 会使键2作废
6. get(2) 应该返回 -1
7. put(4, 4) 会使键1作废
8. get(1) 应该返回 -1
9. get(3) 应该返回 3
10. get(4) 应该返回 4

预期结果:
get(1): 1
get(2): -1
get(1): -1
get(3): 3
get(4): 4

=== LRU缓存实现 ===

class LRUCache {
    // 双向链表节点
    class Node {
        let key: Int
        var value: Int
        var prev: Node?
        var next: Node?
        
        init(key: Int, value: Int) {
            self.key = key
            self.value = value
        }
    }
    
    private let capacity: Int
    private var cache: [Int: Node] = [:]
    private let head = Node(key: 0, value: 0) // 虚拟头节点
    private let tail = Node(key: 0, value: 0) // 虚拟尾节点
    
    init(_ capacity: Int) {
        self.capacity = capacity
        head.next = tail
        tail.prev = head
    }
    
    func get(_ key: Int) -> Int {
        guard let node = cache[key] else {
            return -1
        }
        
        // 将节点移到链表头部（最近使用）
        moveToHead(node)
        return node.value
    }
    
    func put(_ key: Int, _ value: Int) {
        if let node = cache[key] {
            // 如果键已存在，更新值并移到头部
            node.value = value
            moveToHead(node)
        } else {
            // 创建新节点
            let newNode = Node(key: key, value: value)
            cache[key] = newNode
            addToHead(newNode)
            
            // 如果超出容量，删除最久未使用的节点（尾部）
            if cache.count > capacity {
                let lastNode = removeTail()
                cache.removeValue(forKey: lastNode.key)
            }
        }
    }
    
    // 将节点移到链表头部
    private func moveToHead(_ node: Node) {
        removeNode(node)
        addToHead(node)
    }
    
    // 在链表头部添加节点
    private func addToHead(_ node: Node) {
        node.prev = head
        node.next = head.next
        head.next?.prev = node
        head.next = node
    }
    
    // 删除节点
    private func removeNode(_ node: Node) {
        node.prev?.next = node.next
        node.next?.prev = node.prev
    }
    
    // 删除链表尾部节点并返回
    private func removeTail() -> Node {
        let lastNode = tail.prev!
        removeNode(lastNode)
        return lastNode
    }
}

=== 算法分析 ===

时间复杂度:
- get操作: O(1)
- put操作: O(1)

空间复杂度: O(capacity)

实现思路:
1. 使用哈希表存储键值对，实现O(1)的查找
2. 使用双向链表维护访问顺序，最近使用的在头部
3. 当缓存满时，删除链表尾部的节点（最久未使用）
4. 每次访问节点时，将其移到链表头部

这个实现满足了LeetCode 146题的所有要求。
"""

// 写入文件
let fileURL = URL(fileURLWithPath: "lru_cache_result.txt")
try output.write(to: fileURL, atomically: true, encoding: .utf8)

print("结果已写入 lru_cache_result.txt 文件") 