#!/usr/bin/env swift

// 简单的测试程序
print("Hello, Swift!")

// 测试基本功能
let numbers = [1, 2, 3, 4, 5]
print("数组: \(numbers)")

// 测试类定义
class SimpleClass {
    var value: Int
    
    init(value: Int) {
        self.value = value
    }
    
    func getValue() -> Int {
        return value
    }
}

let obj = SimpleClass(value: 42)
print("对象值: \(obj.getValue())")

print("测试完成!") 