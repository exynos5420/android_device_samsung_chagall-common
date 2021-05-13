#
# Copyright (C) 2018 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

PRODUCT_CHARACTERISTICS := tablet

DEVICE_PATH := device/samsung/chagall-common

# Overlays
DEVICE_PACKAGE_OVERLAYS += $(DEVICE_PATH)/overlay
PRODUCT_ENFORCE_RRO_EXCLUDED_OVERLAYS += \
    device/samsung/chagall-common/overlay/lineage-sdk \
    device/samsung/chagall-common/overlay/hardware/samsung/AdvancedDisplay

# AdvancedDisplay (MDNIE)
PRODUCT_PACKAGES += \
    AdvancedDisplay

# Audio
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/audio/mixer_paths_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_0.xml

# Bluetooth
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/bluetooth/bt_vendor.conf:$(TARGET_COPY_OUT_SYSTEM)/etc/bluetooth/bt_vendor.conf

# Boot animation
TARGET_SCREEN_HEIGHT := 2560
TARGET_SCREEN_WIDTH := 1600

# Fingerprint
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.1-service \
    fingerprint.universal5420 \
    validityService

# Key-layout
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/configs/idc/Synaptics_HID_TouchPad.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/Synaptics_HID_TouchPad.idc \
    $(DEVICE_PATH)/configs/idc/Synaptics_RMI4_TouchPad_Sensor.idc:$(TARGET_COPY_OUT_SYSTEM)/usr/idc/Synaptics_RMI4_TouchPad_Sensor.idc \
    $(DEVICE_PATH)/configs/keylayout/Button_Jack.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/Button_Jack.kl \
    $(DEVICE_PATH)/configs/keylayout/gpio_keys.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/gpio_keys.kl \
    $(DEVICE_PATH)/configs/keylayout/sec_touchkey.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/sec_touchkey.kl \
    $(DEVICE_PATH)/configs/keylayout/sec_touchscreen.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/sec_touchscreen.kl

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml

# Properties
-include $(LOCAL_PATH)/system_prop.mk

# Shipping API level
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_k.mk)

# Inherit from universal5420-common
$(call inherit-product, device/samsung/universal5420-common/device-common.mk)

# call the proprietary setup
$(call inherit-product-if-exists, vendor/samsung/chagall-common/chagall-common-vendor.mk)
