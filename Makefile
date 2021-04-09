export THEOS = /var/theos
export ARCHS = arm64 arm64e
THEOS_DEVICE_IP = 10.0.0.26

INSTALL_TARGET_PROCESSES = SpringBoard
TARGET_IPHONEOS_DEPLOYMENT_VERSION = 13.3

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Aux
Aux_FILES = Avx.x
Aux_FRAMEWORKS = UIKit
Aux_PRIVATE_FRAMEWORKS = MediaRemote
Aux_CFLAGS = -fobjc-arc

include $(THEOS)/makefiles/tweak.mk
SUBPROJECTS += auxprefs
include $(THEOS)/makefiles/aggregate.mk
