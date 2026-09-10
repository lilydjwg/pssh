#!/bin/bash
# 一键构建 RPM 包脚本

set -e

echo "=== PSSH RPM 构建脚本 ==="

# 1. 清理并构建源码包
echo ">>> 步骤 1: 构建源码包..."
rm -rf dist/
python3 -m build --sdist

# 2. 设置 rpmbuild 环境
echo ">>> 步骤 2: 设置 rpmbuild 环境..."
if [ ! -d "$HOME/rpmbuild" ]; then
    rpmdev-setuptree
fi

# 3. 获取版本信息
VERSION=$(python3 -c "from psshlib.version import VERSION; print(VERSION)")
echo ">>> PSSH 版本: $VERSION"

# 4. 复制文件
echo ">>> 步骤 3: 复制文件到 rpmbuild 目录..."
cp dist/pssh-${VERSION}.tar.gz $HOME/rpmbuild/SOURCES/
cp pssh.spec $HOME/rpmbuild/SPECS/

# 5. 更新 spec 文件中的版本号
sed -i "s/^Version:.*/Version:        ${VERSION}/" $HOME/rpmbuild/SPECS/pssh.spec

# 6. 构建 RPM
echo ">>> 步骤 4: 构建 RPM 包..."
rpmbuild -ba $HOME/rpmbuild/SPECS/pssh.spec

echo "=== 构建完成 ==="
echo "RPM 包位置: $HOME/rpmbuild/RPMS/noarch/pssh-${VERSION}*.rpm"
echo "SRPM 包位置: $HOME/rpmbuild/SRPMS/pssh-${VERSION}*.src.rpm"
