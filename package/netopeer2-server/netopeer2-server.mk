NETOPEER2_SERVER_VERSION = 0.7-r2
NETOPEER2_SERVER_SITE = $(call github,CESNET,Netopeer2,v$(NETOPEER2_SERVER_VERSION))
NETOPEER2_SERVER_SUBDIR = server
NETOPEER2_SERVER_INSTALL_STAGING = NO
NETOPEER2_SERVER_LICENSE = BSD-3c
NETOPEER2_SERVER_LICENSE_FILES = LICENSE
NETOPEER2_SERVER_DEPENDENCIES = libnetconf2 netopeer2-keystored

define NETOPEER2_SERVER_INSTALL_DAEMON_SCRIPT
	$(INSTALL) -D -m 0751 package/netopeer2-server/S91netopeer2-server \
		$(TARGET_DIR)/etc/init.d/
endef

NETOPEER2_SERVER_POST_INSTALL_TARGET_HOOKS = NETOPEER2_SERVER_INSTALL_DAEMON_SCRIPT

# prevent an attempted chown to root:root
NETOPEER2_SERVER_CONF_OPTS += -DSYSREPOCTL_ROOT_PERMS="-p 666"
NETOPEER2_SERVER_MAKE_ENV = LD_LIBRARY_PATH+=$(HOST_DIR)/usr/lib
# the .pc file is for the target, and therefore not consulted during the build
NETOPEER2_SERVER_CONF_OPTS += -DKEYSTORED_KEYS_DIR=/etc/keystored/keys

$(eval $(cmake-package))