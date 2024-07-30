#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 修改Tailscale路径
#sed -i '/\/etc\/init\.d\/tailscale/d;/\/etc\/config\/tailscale/d;' feeds/packages/net/tailscale/Makefile

# 修改默认IP
sed -i 's/192.168.1.1/10.10.10.1/g' package/base-files/files/bin/config_generate

# 取消bootstrap为默认主题
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
sed -i 's/luci-theme-bootstrap/luci-theme-argon-18.06/g' feeds/luci/collections/luci/Makefile
sed -i 's/luci-theme-bootstrap/luci-theme-argon-18.06/g' feeds/luci/collections/luci-nginx/Makefile
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci-nginx/Makefile

# 删除lede源码对软件源的替换
sed -i '/sed -i '\''s#downloads.openwrt.org#mirrors.tencent.com\/lede#g'\'' \/etc\/opkg\/distfeeds.conf/d' package/lean/default-settings/files/zzz-default-settings

# 加入istore软件源，\x27是单引号的十六进制
sed -i '/exit 0/i sed -i \x27\$a src/gz istore https://istore.linkease.com/repo/aarch64_cortex-a53/nas/\x27 /etc/opkg/distfeeds.conf' package/lean/default-settings/files/zzz-default-settings

# 加入作者信息
sed -i "s/DISTRIB_DESCRIPTION='*.*'/DISTRIB_DESCRIPTION='SpringWRT-$(date +%Y%m%d)'/g" package/lean/default-settings/files/zzz-default-settings

# 更改主机名
sed -i "s/hostname='.*'/hostname='SpringWRT'/g" package/base-files/files/bin/config_generate

# 调整接口菜单
sed -i '/option Interface/d'  package/network/services/dropbear/files/dropbear.config
