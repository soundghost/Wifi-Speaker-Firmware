#!/bin/bash

##-----------------Del duplicate packages------------------

rm -rf feeds/packages/net/open-app-filter
rm -rf feeds/luci/applications/luci-app-appfilter

#删除低版本golang并升级到1.25.x
#rm -rf feeds/packages/lang/golang
#git clone https://github.com/sbwml/packages_lang_golang -b 25.x feeds/packages/lang/golang

# 更新 xray-core Makefile
#curl -sSL https://raw.githubusercontent.com/immortalwrt/packages/refs/heads/master/net/xray-core/Makefile -o package/feeds/packages/xray-core/Makefile
