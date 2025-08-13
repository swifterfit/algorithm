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

// 测试代码
func testLRUCache() {
    let lruCache = LRUCache(2)
    
    print("=== LRU缓存测试 ===")
    
    lruCache.put(1, 1)
    lruCache.put(2, 2)
    print("get(1): \(lruCache.get(1))") // 返回 1
    
    lruCache.put(3, 3) // 该操作会使得关键字 2 作废
    print("get(2): \(lruCache.get(2))") // 返回 -1 (未找到)
    
    lruCache.put(4, 4) // 该操作会使得关键字 1 作废
    print("get(1): \(lruCache.get(1))") // 返回 -1 (未找到)
    print("get(3): \(lruCache.get(3))") // 返回 3
    print("get(4): \(lruCache.get(4))") // 返回 4
}

// 运行测试
testLRUCache()
