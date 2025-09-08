#!/bin/bash

#更改默认地址为192.168.9.1
sed -i 's/192.168.1.1/192.168.9.1/g' package/base-files/files/bin/config_generate

#删除低版本golang并升级到1.25.x
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 25.x feeds/packages/lang/golang

#删除低版本v2ray-geodata和mosdns
rm -rf feeds/packages/net/v2ray-geodata
rm -rf feeds/packages/net/mosdns

# 移除 openwrt feeds 自带的核心库
rm -rf feeds/packages/net/{xray-core,v2ray-core,v2ray-geodata,sing-box,chinadns-ng,dns2socks,hysteria,ipt2socks,microsocks,naiveproxy,shadowsocks-libev,shadowsocks-rust,shadowsocksr-libev,simple-obfs,tcping,trojan-plus,tuic-client,v2ray-plugin,xray-plugin,geoview,shadow-tls}

# 移除 openwrt feeds 过时的luci版本
rm -rf feeds/luci/applications/luci-app-passwall

#添加软件包
git clone https://github.com/xiaorouji/openwrt-passwall-packages package/passwall-packages
git clone https://github.com/xiaorouji/openwrt-passwall package/passwall-luci
git clone https://github.com/zzsj0928/luci-app-pushbot package/luci-app-pushbot
git clone https://github.com/sbwml/luci-app-airconnect.git  package/luci-app-airconnect
git clone https://github.com/EasyTier/luci-app-easytier.git package/luci-app-easytier
git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/luci-app-adguardhome
git clone https://github.com/destan19/OpenAppFilter package/OpenAppFilter
git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata
git clone --depth=1 https://github.com/fw876/helloworld.git package/helloworld
git -C package/helloworld pull

#添加360T7 108M 512M-Ram USB支持
cat >> target/linux/mediatek/files-5.4/arch/arm64/boot/dts/mediatek/mt7981-360-t7-108M.dts << EOF
&xhci {
        mediatek,u3p-dis-msk = <0x0>;
        phys = <&u2port0 PHY_TYPE_USB2>,
                   <&u3port0 PHY_TYPE_USB3>;
        status = "okay";
};
EOF

#添加K2P 32M nand USB支持
sed -i 's/15744k/32448k/g' target/linux/ramips/image/mt7621.mk
sed -i 's/"Phicomm K2P";/"Phicomm K2P (32M USB)";/g' target/linux/ramips/dts/mt7621_phicomm_k2p.dts
sed -i '/spi-max-frequency/a\\t\tbroken-flash-reset;' target/linux/ramips/dts/mt7621_phicomm_k2p.dts
sed -i 's/<0xa0000 0xf60000>/<0xa0000 0x1fb0000>/g' target/linux/ramips/dts/mt7621_phicomm_k2p.dts
