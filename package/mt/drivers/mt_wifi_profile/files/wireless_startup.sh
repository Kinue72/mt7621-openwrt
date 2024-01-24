#!/bin/sh

apply_wireless_config() {
    local interface=$1
    local main_interface=$2
    local dat_file=$3

    local enable=$(grep -e "ApCliEnable=" "$dat_file")

    if [ "$enable" = "ApCliEnable=0" ]; then
        iwpriv "$interface" set ApCliAutoConnect=0
        iwpriv "$interface" set "$enable"
        return
    fi

    local ssid=$(grep -e "ApCliSsid=" "$dat_file")
    local kick=$(grep -e "KickStaRssiLow=" "$dat_file")

    logger -t MTK-Wi-Fi "iwpriv $interface set ApCliAutoConnect=3"

    iwpriv "$interface" set "$ssid"
    iwpriv "$interface" set ApCliAutoConnect=3
    iwpriv "$interface" set "$enable"

    iwpriv "$main_interface" set "$kick"
}

mkdir -p /tmp/mtk/wifi

for dat in $(ls -1 /etc/wireless/mt7615)
do
    cp -f /etc/wireless/mt7615/$dat /tmp/mtk/wifi/$dat.last
done

sleep 60

# 5GHz
apply_wireless_config "apcli0" "ra0" "/etc/wireless/mt7615/mt7615.1.dat"
# 2.4GHz
apply_wireless_config "apclii0" "rai0" "/etc/wireless/mt7615/mt7615.2.dat"

# Move 2.4GHz and 5GHz Wi-Fi to CPU2 and CPU3
mask=4
for irq in $(grep -E 'ra(.{0,1}0)' /proc/interrupts | cut -d: -f1 | sed 's, *,,')
do
    echo "$mask" > "/proc/irq/$irq/smp_affinity"
    mask=8
done