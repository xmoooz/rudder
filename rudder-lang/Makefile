# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: 2020 Normation SAS

include ../rust.makefile

DOC_EXAMPLES := $(wildcard docs/examples/*.rl)

dependencies:
	$(PKG_INSTALLER) perl python3

install:
	mkdir -p $(DESTDIR)/opt/rudder/etc
	mkdir -p $(DESTDIR)/opt/rudder/bin
	mkdir -p $(DESTDIR)/opt/rudder/share/python
	mkdir -p $(DESTDIR)/opt/rudder/share/rudder-lang/lib
	mkdir -p $(DESTDIR)/opt/rudder/share/rudder-lang/tools

	# Install executable and helper scripts
	install -m 755 target/release/rudderc $(DESTDIR)/opt/rudder/bin/rudderc
	install -m 755 tools/tester.sh $(DESTDIR)/opt/rudder/share/rudder-lang/tools/tester.sh
	install -m 755 tools/cfjson_tester $(DESTDIR)/opt/rudder/share/rudder-lang/tools/cfjson_tester
	install -m 755 tools/generate_lib $(DESTDIR)/opt/rudder/share/rudder-lang/tools/generate_lib
	
	# Copy configuration and library files
	# required for rudderc execution
	install -m 640 tools/rudderc-prod.conf $(DESTDIR)/opt/rudder/etc/rudderc.conf
	install -m 644 libs/corelib.rl $(DESTDIR)/opt/rudder/share/rudder-lang/lib/corelib.rl
	install -m 644 libs/cfengine_core.rl $(DESTDIR)/opt/rudder/share/rudder-lang/lib/cfengine_core.rl
	install -m 644 libs/oslib.rl $(DESTDIR)/opt/rudder/share/rudder-lang/lib/oslib.rl

	# Python libs
	install -m 644 tools/docopt.py $(DESTDIR)/opt/rudder/share/python/docopt.py
	cp -r tools/jsondiff $(DESTDIR)/opt/rudder/share/python/
	chmod 755 $(DESTDIR)/opt/rudder/share/python/jsondiff
	chmod 644 $(DESTDIR)/opt/rudder/share/python/jsondiff/*

	# TODO run in postinst script
	# /opt/rudder/share/rudder-lang/tools/generate_lib

test-docs: $(DOC_EXAMPLES)

$(DOC_EXAMPLES):
	cargo run -- --config-file tools/rudderc-dev.conf --input $@ --output $@.cf
	rm $@.cf

docs:
	mkdir -p target/docs
	asciidoctor --destination-dir=target/docs docs/index.adoc

.PHONY: docs $(DOC_EXAMPLES)
