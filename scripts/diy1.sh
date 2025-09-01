#!/bin/bash

#更改默认地址为192.168.9.1
sed -i 's/192.168.1.1/192.168.9.1/g' package/base-files/files/bin/config_generate

#添加软件包
# echo 'src-git smpackage https://github.com/kenzok8/small-package' >> feeds.conf.default
# echo 'src-git-full small https://github.com/kenzok8/small' >>feeds.conf.default
# echo 'src-git helloworld https://github.com/fw876/helloworld' >> feeds.conf.default
git clone https://github.com/zzsj0928/luci-app-pushbot package/luci-app-pushbot
git clone https://github.com/sbwml/luci-app-airconnect.git  package/luci-app-airconnect
git clone https://github.com/EasyTier/luci-app-easytier.git package/luci-app-easytier
git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/luci-app-adguardhome
git clone https://github.com/destan19/OpenAppFilter package/OpenAppFilter

#添加360T7 108M 512M-Ram USB支持
# echo '&xhci {' >> target/linux/mediatek/files-5.4/arch/arm64/boot/dts/mediatek/mt7981-360-t7-108M.dts
# echo '        mediatek,u3p-dis-msk = <0x0>;' >> target/linux/mediatek/files-5.4/arch/arm64/boot/dts/mediatek/mt7981-360-t7-108M.dts
# echo '        phys = <&u2port0 PHY_TYPE_USB2>,' >> target/linux/mediatek/files-5.4/arch/arm64/boot/dts/mediatek/mt7981-360-t7-108M.dts
# echo '                   <&u3port0 PHY_TYPE_USB3>;' >> target/linux/mediatek/files-5.4/arch/arm64/boot/dts/mediatek/mt7981-360-t7-108M.dts
# echo '        status = "okay";' >> target/linux/mediatek/files-5.4/arch/arm64/boot/dts/mediatek/mt7981-360-t7-108M.dts
# echo '};' >> target/linux/mediatek/files-5.4/arch/arm64/boot/dts/mediatek/mt7981-360-t7-108M.dts

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
