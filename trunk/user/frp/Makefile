THISDIR := $(shell pwd)

all: 

clean:

romfs:
ifeq ($(CONFIG_FIRMWARE_INCLUDE_FRPC),y)
	$(ROMFSINST) -p +x $(THISDIR)/$(FRP_NAME)/frpc /usr/bin/frpc
endif
ifeq ($(CONFIG_FIRMWARE_INCLUDE_FRPS),y)
	$(ROMFSINST) -p +x $(THISDIR)/$(FRP_NAME)/frps /usr/bin/frps
endif
	$(ROMFSINST) -p +x $(THISDIR)/frp.sh /usr/bin/frp.sh
	$(ROMFSINST) /etc_ro/frp_script.sh
