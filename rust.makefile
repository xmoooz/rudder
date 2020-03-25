# SPDX-License-Identifier: GPL-3.0-or-later
# SPDX-FileCopyrightText: 2019-2020 Normation SAS

build-env:
	curl https://sh.rustup.rs -sSf | sh
	rustup component add clippy
	cargo install cargo-update
	cargo install cargo-audit

build-env-update:
	rustup self update
	rustup update
	cargo install-update -a

clean:
	cargo clean
	rm -rf target

veryclean: clean
	rustup self uninstall
	rm -rf ~/.rustup ~/.cargo

# fmt, build, test, audit, clean, bench, etc.
%:
	cargo $@

outdated:
	# only check on our dependencies
	cargo outdated --root-deps-only

deps-update: update outdated
	[ -d fuzz ] && cd fuzz && cargo update

dev-env: build-env
	rustup component add rustfmt
	cargo install cargo-outdated
	cargo install tokei

stats:
	@ echo -n "TODOS: " && grep -r TODO src | wc -l
	@ tokei
