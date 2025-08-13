#!/usr/bin/env swift

print("开始运行LRU缓存测试...")

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
        print("LRU缓存初始化，容量: \(capacity)")
    }
    
    func get(_ key: Int) -> Int {
        guard let node = cache[key] else {
            print("获取键 \(key) 失败，返回 -1")
            return -1
        }
        
        // 将节点移到链表头部（最近使用）
        moveToHead(node)
        print("获取键 \(key) 成功，值: \(node.value)")
        return node.value
    }
    
    func put(_ key: Int, _ value: Int) {
        if let node = cache[key] {
            // 如果键已存在，更新值并移到头部
            node.value = value
            moveToHead(node)
            print("更新键 \(key) 的值: \(value)")
        } else {
            // 创建新节点
            let newNode = Node(key: key, value: value)
            cache[key] = newNode
            addToHead(newNode)
            print("添加新键值对: \(key) -> \(value)")
            
            // 如果超出容量，删除最久未使用的节点（尾部）
            if cache.count > capacity {
                let lastNode = removeTail()
                cache.removeValue(forKey: lastNode.key)
                print("缓存已满，删除最久未使用的键: \(lastNode.key)")
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

// 测试代码
func testLRUCache() {
    print("=== LRU缓存测试开始 ===")
    
    let lruCache = LRUCache(2)
    
    lruCache.put(1, 1)
    lruCache.put(2, 2)
    print("get(1): \(lruCache.get(1))") // 返回 1
    
    lruCache.put(3, 3) // 该操作会使得关键字 2 作废
    print("get(2): \(lruCache.get(2))") // 返回 -1 (未找到)
    
    lruCache.put(4, 4) // 该操作会使得关键字 1 作废
    print("get(1): \(lruCache.get(1))") // 返回 -1 (未找到)
    print("get(3): \(lruCache.get(3))") // 返回 3
    print("get(4): \(lruCache.get(4))") // 返回 4
    
    print("=== LRU缓存测试结束 ===")
}

// 运行测试
testLRUCache() 