#!/bin/bash

#添加软件包
git clone https://github.com/badaix/snapos.git
git clone https://github.com/zzsj0928/luci-app-pushbot package/luci-app-pushbot
git clone https://github.com/sbwml/luci-app-airconnect.git  package/luci-app-airconnect
git clone https://github.com/EasyTier/luci-app-easytier.git package/luci-app-easytier
#git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/luci-app-adguardhome
#git clone https://github.com/destan19/OpenAppFilter package/OpenAppFilter
git clone https://github.com/ashdkv/ympd-openwrt.git package/ympd
#git clone --depth=1 https://github.com/fw876/helloworld.git package/helloworld
#git -C package/helloworld pull
