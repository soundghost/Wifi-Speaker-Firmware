#!/bin/bash

##-----------------Del duplicate packages------------------
rm -rf feeds/packages/net/open-app-filter
rm -rf feeds/luci/applications/luci-app-appfilter
git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

#删除低版本golang并升级到1.25.x
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 25.x feeds/packages/lang/golang

# 更新 xray-core Makefile
curl -sSL https://raw.githubusercontent.com/immortalwrt/packages/refs/heads/master/net/xray-core/Makefile -o package/feeds/packages/xray-core/Makefile

#删除低版本v2ray-geodata和mosdns
#find ./ | grep Makefile | grep v2ray-geodata | xargs rm -f
#find ./ | grep Makefile | grep mosdns | xargs rm -f
rm -rf feeds/packages/net/v2ray-geodata
rm -rf feeds/packages/net/mosdns
