# WCDB.objc 集成问题解决方案

## 问题分析
根据您提供的错误截图，主要问题包括：
- Unknown type name 'offset_t'
- Unknown type name 'Location' 
- No type named 'Location' in 'WCDB::Range'
- 编译错误过多导致停止编译

## 解决方案

### 1. 检查 Podfile 配置

确保您的 Podfile 配置正确：

```ruby
platform :ios, '9.0'
use_frameworks!

target 'YourProjectName' do
  pod 'WCDB.objc'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_BITCODE'] = 'NO'
      config.build_settings['CLANG_CXX_LANGUAGE_STANDARD'] = 'c++14'
      config.build_settings['CLANG_CXX_LIBRARY'] = 'libc++'
    end
  end
end
```

### 2. 项目设置修改

在 Xcode 中进行以下设置：

#### Build Settings:
- **C++ Language Dialect**: C++14 [-std=c++14]
- **C++ Standard Library**: libc++ (libc++ LLVM C++ standard library with C++11 support)
- **Enable Bitcode**: NO
- **Other Linker Flags**: 添加 `-lc++`

#### Header Search Paths:
确保包含了正确的头文件搜索路径，通常 CocoaPods 会自动处理，但如果有问题可以手动添加：
- `$(SRCROOT)/Pods/WCDB.objc`

### 3. 正确的头文件引入

在需要使用 WCDB 的文件中，确保正确引入头文件：

```objc
// 在 .h 文件中
#import <WCDB/WCDB.h>

// 或者在 .m/.mm 文件中
#import <WCDB/WCDB.h>
```

### 4. 文件扩展名检查

如果您的实现文件中使用了 C++ 代码或 WCDB 的 C++ 接口，确保文件扩展名为 `.mm` 而不是 `.m`：

- 将 `.m` 文件重命名为 `.mm`
- 或者在 Build Settings 中设置 "Compile Sources As" 为 "Objective-C++"

### 5. 预编译头文件配置

如果使用了预编译头文件（.pch），在其中添加：

```objc
#ifdef __OBJC__
    #import <UIKit/UIKit.h>
    #import <Foundation/Foundation.h>
    #import <WCDB/WCDB.h>
#endif
```

### 6. 模块化导入问题

如果使用了模块化导入，尝试以下方式：

```objc
// 方式1：传统导入
#import <WCDB/WCDB.h>

// 方式2：模块导入（如果支持）
@import WCDB;
```

### 7. 清理和重新编译

执行以下步骤：

1. 清理项目：Product → Clean Build Folder (Cmd+Shift+K)
2. 删除 DerivedData：
   ```bash
   rm -rf ~/Library/Developer/Xcode/DerivedData
   ```
3. 重新安装 Pod：
   ```bash
   pod deintegrate
   pod install
   ```
4. 重新打开 .xcworkspace 文件进行编译

### 8. 常见的代码使用示例

```objc
// 数据库初始化
@interface YourModel : NSObject <WCTTableCoding>
@property (nonatomic, assign) int identifier;
@property (nonatomic, strong) NSString *name;
@end

@implementation YourModel

WCDB_IMPLEMENTATION(YourModel)
WCDB_SYNTHESIZE(YourModel, identifier)
WCDB_SYNTHESIZE(YourModel, name)

WCDB_PRIMARY(YourModel, identifier)

@end

// 数据库操作
- (void)setupDatabase {
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"sample.db"];
    
    WCTDatabase *database = [[WCTDatabase alloc] initWithPath:path];
    [database createTableAndIndexesOfName:@"yourTable" withClass:YourModel.class];
    
    // 插入数据
    YourModel *model = [[YourModel alloc] init];
    model.identifier = 1;
    model.name = @"Sample";
    
    [database insertObject:model into:@"yourTable"];
    
    // 查询数据
    NSArray<YourModel *> *results = [database getObjectsOfClass:YourModel.class fromTable:@"yourTable"];
}
```

### 9. 版本兼容性检查

确保使用的 WCDB.objc 版本与您的项目兼容：

```ruby
# 在 Podfile 中指定版本
pod 'WCDB.objc', '~> 1.0.8.2'
```

### 10. 调试步骤

如果问题仍然存在：

1. 检查 Pods 目录中 WCDB 是否正确安装
2. 验证 Build Phases 中 Link Binary With Libraries 是否包含必要的库
3. 检查是否有冲突的第三方库
4. 尝试创建一个新的测试项目验证 WCDB 集成

## 总结

大多数 WCDB.objc 集成问题都是由于 C++ 标准库设置、头文件路径或文件扩展名导致的。按照上述步骤逐一检查和修复，应该能解决您遇到的编译错误。

如果问题仍然存在，请提供：
1. 完整的 Podfile 内容
2. 项目的 Build Settings 截图
3. 具体的错误日志（完整版本）

这样可以提供更针对性的解决方案。