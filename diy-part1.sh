#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
# echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
# echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
echo 'src-git lienol https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

cd lede
mkdir package/luci-app-openclash
cd package/luci-app-openclash
git init
git remote add -f origin https://github.com/vernesong/OpenClash.git
git config core.sparsecheckout true
echo "luci-app-openclash" >> .git/info/sparse-checkout
git pull origin master
git branch --set-upstream-to=origin/master master
cd ..
cd lean
# git clone https://github.com/jerrykuku/lua-maxminddb.git
# git clone https://github.com/jerrykuku/luci-app-vssr.git
rm -rf luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git
cd ..
# git clone https://github.com/destan19/OpenAppFilter.git
cd ..
# rm package/lean/luci-app-flowoffload -fr
# rm package/lean/shortcut-fe/ -fr
# rm package/lean/luci-app-sfe/ -fr
# cd package/lean/ && git clone https://github.com/lisaac/luci-app-dockerman.git
sed -i '/spi-max-frequency/a\\t\tbroken-flash-reset;' target/linux/ath79/dts/ar9344_tplink_tl-wdrxxxx.dtsi
sed -i 's/<0x020000 0x7d0000>/<0x020000 0x17d0000>/g' target/linux/ath79/dts/ar9344_tplink_tl-wdrxxxx.dtsi
sed -i 's/<0x7f0000 0x010000>/<0x17f0000 0x010000>/g' target/linux/ath79/dts/ar9344_tplink_tl-wdrxxxx.dtsi
sed -i 's/8000k/32576k/g' target/linux/ath79/image/common-tp-link.mk

