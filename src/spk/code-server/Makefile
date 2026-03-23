SPK_NAME = code-server
SPK_VERS = 4.112.0
SPK_REV = 1
SPK_ICON = src/$(SPK_NAME).png

DEPENDS =

UNSUPPORTED_ARCHS = $(OLD_PPC_ARCHS) $(ARMv5_ARCHS)

include ../../mk/spksrc.common.mk

MAINTAINER = iamjairo
DESCRIPTION = "JS - Editor: VS Code in the browser for Synology NAS, powered by code-server."

HOMEPAGE = https://github.com/coder/code-server
LICENSE  = MIT

SPK_DEPENDS =

DSM_UI_DIR = app
DSM_UI_CONFIG = src/app/config
DSM_APP_NAME = IamJairo.CodeServer.AppInstance

WIZARDS_DIR = src/wizard

STARTABLE = yes
SERVICE_SETUP = src/service-setup.sh
SSS_SCRIPT = src/start-stop-status.sh

COPY_TARGET = nop
POST_STRIP_TARGET = code_server_strip_target

CODE_SERVER_ARCH =
ifeq ($(findstring $(ARCH),$(ARMv7_ARCHS) $(ARMv7L_ARCHS)),$(ARCH))
CODE_SERVER_ARCH = linux-armv7l
endif
ifeq ($(findstring $(ARCH),$(ARMv8_ARCHS)),$(ARCH))
CODE_SERVER_ARCH = linux-arm64
endif
ifeq ($(findstring $(ARCH),$(x64_ARCHS)),$(ARCH))
CODE_SERVER_ARCH = linux-amd64
endif
ifeq ($(strip $(CODE_SERVER_ARCH)),)
$(error Arch $(ARCH) not supported)
endif

include ../../mk/spksrc.spk.mk

.PHONY: code_server_strip_target
code_server_strip_target:
	install -m 755 -d $(STAGING_DIR)/lib/
	curl -kL https://github.com/coder/code-server/releases/download/v$(SPK_VERS)/code-server-$(SPK_VERS)-$(CODE_SERVER_ARCH).tar.gz \
		| tar xz -C $(STAGING_DIR)/lib/
	mv $(STAGING_DIR)/lib/code-server-$(SPK_VERS)-$(CODE_SERVER_ARCH) $(STAGING_DIR)/lib/code-server

	install -m 755 -d $(STAGING_DIR)/etc/
	install -m 644 src/etc/alias.code-server.conf $(STAGING_DIR)/etc/alias.code-server.conf
	install -m 644 src/etc/code-server.yaml $(STAGING_DIR)/etc/code-server.yaml

	install -m 755 -d $(STAGING_DIR)/app/
	install -m 644 src/app/config $(STAGING_DIR)/app/config
	install -m 644 src/app/code-server.js $(STAGING_DIR)/app/code-server.js

	install -m 755 -d $(STAGING_DIR)/app/images/
	install -m 644 src/app/images/*.png $(STAGING_DIR)/app/images/

	install -m 755 -d $(STAGING_DIR)/app/texts/enu/
	install -m 644 src/app/texts/enu/strings $(STAGING_DIR)/app/texts/enu/strings
