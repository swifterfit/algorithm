#!/bin/bash

# WCDB.objc 集成问题修复脚本
# 在项目根目录运行此脚本

echo "开始修复 WCDB.objc 集成问题..."

# 1. 清理现有的 Pods
echo "步骤 1: 清理现有 Pods..."
if [ -f "Podfile.lock" ]; then
    rm Podfile.lock
fi

if [ -d "Pods" ]; then
    rm -rf Pods
fi

if [ -f "*.xcworkspace" ]; then
    rm -rf *.xcworkspace
fi

# 2. 清理 DerivedData
echo "步骤 2: 清理 DerivedData..."
rm -rf ~/Library/Developer/Xcode/DerivedData

# 3. 重新安装 Pods
echo "步骤 3: 重新安装 Pods..."
pod deintegrate 2>/dev/null || echo "No existing integration to remove"
pod install

echo "修复完成！"
echo ""
echo "接下来请手动执行以下步骤："
echo "1. 打开 .xcworkspace 文件（不是 .xcodeproj）"
echo "2. 在 Xcode 中检查 Build Settings："
echo "   - C++ Language Dialect: C++14"
echo "   - C++ Standard Library: libc++"
echo "   - Enable Bitcode: NO"
echo "3. 确保所有使用 WCDB 的实现文件扩展名为 .mm"
echo "4. Clean Build Folder (Cmd+Shift+K) 然后重新编译"