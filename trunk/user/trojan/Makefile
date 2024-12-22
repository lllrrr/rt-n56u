THISDIR = $(shell pwd)

all:

clean:

romfs:
	$(ROMFSINST) -p +x $(THISDIR)/trojan /usr/bin/trojan
	$(ROMFSINST) -p +x $(THISDIR)/cacert.pem /usr/bin/cacert.pem

