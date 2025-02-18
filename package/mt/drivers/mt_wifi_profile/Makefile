#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=mt_wifi_profile
PKG_VERSION:=2
PKG_RELEASE:=2

PKG_CONFIG_DEPENDS := \
	CONFIG_MTK_CHIP_MT7603E_MT7612E \
	CONFIG_MTK_CHIP_MT7603E_MT7615E \
	CONFIG_MTK_CHIP_MT7615E \
	CONFIG_MTK_CHIP_MT7615E_DBDC \
	CONFIG_MTK_CHIP_MT7915D

include $(INCLUDE_DIR)/package.mk

define Package/mt_wifi_profile
  SECTION:=net
  CATEGORY:=Network
  TITLE:=MTK wifi AP config
  DEPENDS:=@TARGET_ramips +wireless-tools
  SUBMENU:=Wireless
endef

define Package/mt_wifi_profile/config
	source "$(SOURCE)/config.in"
endef

define Package/mt_wifi_profile/description
  MT_WiFi auto config for MT7603/MT7612/MT7615/MT7915 chips
endef

define Build/Compile
endef

define Package/mt_wifi_profile/install
	$(INSTALL_DIR) $(1)/etc/wireless/mt7615/
	$(INSTALL_DIR) $(1)/etc_ro/Wireless/RT2860AP/
	$(INSTALL_DIR) $(1)/etc_ro/Wireless/
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_DIR) $(1)/etc_ro/wlan/

ifeq ($(CONFIG_MTK_CHIP_MT7603E_MT7612E),y)
	$(INSTALL_DATA) ./files/7603_7612-l1profile.dat $(1)/etc/wireless/l1profile.dat
	$(INSTALL_DATA) ./files/mt7603.dat $(1)/etc/wireless/mt7615/mt7615.1.dat
	$(INSTALL_DATA) ./files/mt7612.dat $(1)/etc/wireless/mt7615/mt7615.2.dat
else ifeq ($(CONFIG_MTK_CHIP_MT7603E_MT7615E),y)
	$(INSTALL_DATA) ./files/7603_7615-l1profile.dat $(1)/etc/wireless/l1profile.dat
	$(INSTALL_DATA) ./files/mt7603.dat $(1)/etc/wireless/mt7615/mt7615.1.dat
	$(INSTALL_DATA) ./files/mt7615.5G.dat $(1)/etc/wireless/mt7615/mt7615.2.dat
else ifeq ($(CONFIG_MTK_CHIP_MT7915D),y)
	$(INSTALL_DATA) ./files/mt7915d/l1profile.dat $(1)/etc/wireless/l1profile.dat
	$(INSTALL_DATA) ./files/mt7915d/mt7915.1.2G.dat $(1)/etc/wireless/mt7615/mt7615.1.dat
	$(INSTALL_DATA) ./files/mt7915d/mt7915.1.5G.dat $(1)/etc/wireless/mt7615/mt7615.2.dat

	$(INSTALL_DATA) ./files/mt7915d/SingleSKU.dat $(1)/etc_ro/Wireless/SingleSKU_mt7615e-sku.dat
	$(INSTALL_DATA) ./files/mt7915d/SingleSKU_BF.dat $(1)/etc_ro/Wireless/SingleSKU_mt7615e-sku-bf.dat
else ifeq ($(CONFIG_MTK_CHIP_MT7615E_DBDC),y)
	$(INSTALL_DATA) ./files/dbdc.l1profile.dat $(1)/etc/wireless/l1profile.dat
	$(INSTALL_DATA) ./files/mt7615.1.2G.dat $(1)/etc/wireless/mt7615/
	$(INSTALL_DATA) ./files/mt7615.1.5G.dat $(1)/etc/wireless/mt7615/
else
	$(INSTALL_DATA) ./files/7615.l1profile.dat $(1)/etc/wireless/l1profile.dat
	$(INSTALL_DATA) ./files/mt7615.2G.dat $(1)/etc/wireless/mt7615/mt7615.1.dat
	$(INSTALL_DATA) ./files/mt7615.5G.dat $(1)/etc/wireless/mt7615/mt7615.2.dat
endif

ifeq ($(CONFIG_MTK_CHIP_MT7915D),n)
	$(INSTALL_DATA) ./files/mt7615e-sku.dat $(1)/etc_ro/Wireless/RT2860AP/SingleSKU.dat
	$(INSTALL_DATA) ./files/mt7615e-sku-bf.dat $(1)/etc_ro/Wireless/RT2860AP/SingleSKU_BF.dat
endif

	$(INSTALL_DATA) ./files/wireless_startup.sh $(1)/etc/init.d/
endef

$(eval $(call BuildPackage,mt_wifi_profile))
