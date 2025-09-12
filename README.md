#### 本项目专注于打造 OpenWrt Wifi 音箱。

除 N1 固件外，都包含下列软件包
· airconnect
· airplay2
· upmpdcli
· mpd-full
· ympd
· pianod
· snapcast ( server/client )

以下是 mpd 的支持情况：
```shell
# mpd -V

Music Player Daemon 0.21.26 (0.21.26)
Copyright 2003-2007 Warren Dukes <warren.dukes@gmail.com>
Copyright 2008-2018 Max Kellermann <max.kellermann@gmail.com>
This is free software; see the source for copying conditions.  There is NO
warranty; not even MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Database plugins:
 simple proxy upnp

Storage plugins:
 local curl

Decoders plugins:
 [mad] mp3 mp2
 [vorbis] ogg oga
 [oggflac] ogg oga
 [flac] flac
 [opus] opus ogg oga
 [faad] aac
 [pcm]

Filters:

Tag plugins:
 id3tag

Output plugins:
 shout null fifo pipe alsa pulse httpd recorder

Encoder plugins:
 null opus wave flac

Input plugins:
 file alsa curl mms

Playlist plugins:
 extm3u m3u pls xspf asx rss soundcloud flac cue embcue

Protocols:
 file:// alsa:// http:// https:// mms:// mmsh:// mmst:// mmsu://

Other features:
 epoll iconv inotify ipv6 tcp un
```

**闭源驱动** | [开源驱动](README_mainline.md)

# Actions-USB-Frimware
使用 GitHub Actions 在线编译定制包括 360T7（512M）USB、K2P（32M）USB、RAX3000M（eMMC）USB 的 immortalwrt-mt798x 固件。
- 添加了 360T7 512M Ram USB 版 DTS 支持。
- 添加了 K2P(32M) 512M Ram USB 版 DTS 支持。
- 默认都集成了 airplay2，这也是本分支存在的理由。
- 初学者自用，修改大佬的代码实现个人需求，不保证 release 的固件好用或能用，请使用者自行鉴别。

## 固件特性
使用 [hanwckf](https://github.com/hanwckf) 大佬的 [immortalwrt-mt798x](https://github.com/hanwckf/immortalwrt-mt798x) 项目仓库，'openwrt-21.02' 分支源码编译，无线使用 mtwifi 原厂无线驱动，内核版本 5.4.x

项目详情：[immortalwrt-mt798x项目介绍](https://cmi.hanwckf.top/p/immortalwrt-mt798x)

固件默认选中软件包
`block-mount、automount、chinadns-ng、curl、e2fsprogs、fdisk、hd-idle、ipv6helper、kmod-sound-core、kmod-usb-audio、kmod-usb-core、kmod-usb-ehci、kmod-usb-ohci、kmod-usb-uhci、kmod-usb-storage、kmod-usb2、kmod-usb3、kmod-wireguard、ksmbd-server、nano` 等，K2P 由于空间小（32M），未包含部分软件。

添加集成软件包
`luci-app-alist、luci-app-appfilter、luci-app-aria2、luci-app-airconnect、luci-app-cpulimit、luci-app-ddns-go、luci-app-airplay2、luci-app-eqos-mtk、luci-app-hd-idle、luci-app-ksmbd、luci-app-netdata、luci-app-pushbot、luci-app-timecontrol、luci-app-ttyd、luci-app-turboacc-mtk、luci-app-unblockneteasemusic、luci-app-upnp、luci-app-vlmcsd、luci-app-watchcat、luci-app-wireguard`，K2P（32M）由于空间限制，未包含全部。
~~并预置 openclash 内核~~（我不喜用此App）

加入由 [1715173329 天灵](https://github.com/1715173329) 使用 js 重写，[237大佬](https://www.right.com.cn/forum/?364126) 适配硬件 QoS 的 [luci-app-eqos-mtk](https://github.com/padavanonly/immortalwrt-mt798x/commit/7c8019ce4bcb1a79c01c517b62e49f059ca70049)

## 使用说明
在 Actions 选择该工作流手动点击 Run workflow 执行编译，等待固件编译完成上传至 releases 发布即可下载

### 配置说明
- 默认 LAN IP 已更改为 `192.168.9.1`，可在 `scripts/diy.sh` 处修改

- 默认构建使用 OpenWrt 原生 luci 无线控制界面，如需使用 MTK SDK 无线控制界面 (luci-app-mtk) 请在 Run workflow 时取消勾选 “Use mtwifi-cfg”，或在 workflow 配置文件中将 `USE_MTWIFI_CFG` 中 `default: true` 的 true 改为 false，重新编译刷入使用

- 默认构建 eeprom 替换为 H3C NX30 Pro 提取版本（仅限RAX3000M eMMC）（来自 [237大佬](https://www.right.com.cn/forum/?364126) 提取）以增大无线功率，**原厂 eeprom 无线信号 2.4G: 23dBm, 5G: 22dBm；替换 nx30pro_eeprom 后 2.4G: 25dBm, 5G: 24dBm**。如需恢复使用默认 eeprom 请在 Run workflow 时取消勾选 “Use nx30pro eeprom”，或在 workflow 配置文件中将 `USE_NX30PRO_EEPROM` 中 `default: true` 的 true 改为 false，重新编译刷入使用

- 默认编译 52 MHz 版本（仅限RAX3000M eMMC），**部分机器因闪存体质差异，使用默认 52 MHz 闪存频率固件可能会出现 I/O 报错，无法正常使用，甚至可能无法启动**，你可以在 [Releases](https://github.com/AngelaCooljx/Actions-rax3000m-emmc/releases) 处查找 26 MHz 版本固件。自行构建需要在 Run workflow 时取消勾选 “Use 52MHz max-frequency”，或在 workflow 配置文件中将 `USE_52MHZ` 中 `default: true` 的 true 改为 false，重新编译刷入使用

## 如何刷入
参考 https://t.me/nanopi_r2s/637 刷入单分区版 GPT BL2 FIP, 再通过 custom U-Boot 刷写 sysupgrade.bin 固件
> 已增加 CMCC RAX3000M eMMC 版 U-Boot，GPT BL2 FIP 刷入方式如下：
> ```
> dd if=mt7981-cmcc_rax3000m-emmc-gpt.bin of=/dev/mmcblk0 bs=512 seek=0 count=34 conv=fsync
> echo 0 > /sys/block/mmcblk0boot0/force_ro
> dd if=/dev/zero of=/dev/mmcblk0boot0 bs=512 count=8192 conv=fsync
> dd if=mt7981-cmcc_rax3000m-emmc-bl2.bin of=/dev/mmcblk0boot0 bs=512 conv=fsync
> dd if=/dev/zero of=/dev/mmcblk0 bs=512 seek=13312 count=8192 conv=fsync
> dd if=mt7981-cmcc_rax3000m-emmc-fip.bin of=/dev/mmcblk0 bs=512 seek=13312 conv=fsync
> ```
> 对应 ImmortalWrt CMCC RAX3000M eMMC version (custom U-Boot layout)、Q-WRT、及其他 eMMC 单分区版固件。

~~路由器进入 uboot 需要手动设置本机 IP 192.168.1.100 网关 192.168.1.1 DNS 192.168.1.1，~~ 新版 custom U-Boot 已支持 DHCP，浏览器输入 `192.168.1.1` 进入 Web-UI 刷写固件，所有文件可在 https://firmware.download.immortalwrt.eu.org/uboot/mediatek 获取

## 注意事项
此分区布局默认不创建 eMMC 闪存最后一块 56G 大分区，你需要使用 `cfdisk /dev/mmcblk0` 为最后一块剩余空闲容量手动创建 /dev/mmcblk0p7 分区并通过 mkfs.ext4 格式化以挂载使用，此后更新刷入其他固件则无需再进行相同操作，固件可以自动挂载

## Credits
- [AngelaCooljx](https://github.com/AngelaCooljx/Actions-rax3000m-emmc)
- [XiaoBinin/Actions-immortalwrt](https://github.com/XiaoBinin/Actions-immortalwrt)
- [ImmortalWrt](https://github.com/immortalwrt/immortalwrt)
- [hanwckf/immortalwrt-mt798x](https://github.com/hanwckf/immortalwrt-mt798x)
- [lgs2007m/immortalwrt-mt798x-rax3000m-emmc](https://github.com/lgs2007m/immortalwrt-mt798x-rax3000m-emmc)
- [GL-iNet](https://github.com/gl-inet)
- [padavanonly](https://github.com/padavanonly)
- [Microsoft Azure](https://azure.microsoft.com)
- [GitHub Actions](https://github.com/features/actions)
- [OpenWrt](https://github.com/openwrt/openwrt)
- [tmate](https://github.com/tmate-io/tmate)
- [mxschmitt/action-tmate](https://github.com/mxschmitt/action-tmate)
- [csexton/debugger-action](https://github.com/csexton/debugger-action)
- [Cowtransfer](https://cowtransfer.com)
- [WeTransfer](https://wetransfer.com/)
- [Mikubill/transfer](https://github.com/Mikubill/transfer)
- [softprops/action-gh-release](https://github.com/softprops/action-gh-release)
- [ActionsRML/delete-workflow-runs](https://github.com/ActionsRML/delete-workflow-runs)
- [dev-drprasad/delete-older-releases](https://github.com/dev-drprasad/delete-older-releases)
- [peter-evans/repository-dispatch](https://github.com/peter-evans/repository-dispatch)

## License

[MIT](https://github.com/P3TERX/Actions-OpenWrt/blob/main/LICENSE) © [**P3TERX**](https://p3terx.com)
