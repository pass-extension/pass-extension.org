# pass extensions - Password Store Extensions (https://pass-extension.org)
# Copyright (C) 2026 Alexandre Pujol <alexandre@pujol.io>
# SPDX-License-Identifier: GPL-3.0-or-later

# Source repositories, shallow-cloned into .ext/<name>
repos := "
	https://git.zx2c4.com/password-store
	https://github.com/pass-extension/pass-audit
	https://github.com/pass-extension/pass-import
	https://github.com/pass-extension/pass-otp
	https://github.com/pass-extension/pass-tomb
	https://github.com/pass-extension/pass-update
"
pandoc := "pandoc --to html --shift-heading-level-by=1"
usage := "
See https://pass-extension.org for more information."

# Show this help message
help:
	@just --list --unsorted
	@printf "%s\n" "{{usage}}"

# Build the website
[group('site')]
build: fetch man
	@hugo --gc --minify

# Serve the website locally, with live reload
[group('site')]
serve: man
	@hugo server

# Clone, or update, the extension repositories into .ext/
[group('sources')]
fetch:
	#!/usr/bin/env bash
	set -euo pipefail
	repos=({{repos}})
	for url in "${repos[@]}"; do
		dir=".ext/$(basename "$url")"
		if [[ -e "$dir/.git" ]]; then
			git -C "$dir" fetch --quiet --depth 1 origin HEAD
			git -C "$dir" reset --quiet --hard FETCH_HEAD
		else
			git clone --quiet --depth 1 "$url" "$dir"
		fi
	done

# Render the man pages to HTML: pandoc markdown when present, groff otherwise
[group('sources')]
man:
	#!/usr/bin/env bash
	set -euo pipefail
	mkdir -p .man
	for f in .ext/*/share/man/man1/*.md; do
		{{pandoc}} --from markdown -o ".man/$(basename "$f" .md).html" "$f"
	done
	for f in .ext/pass-otp/pass-otp.1 .ext/password-store/man/pass.1; do
		{{pandoc}} --from man -o ".man/$(basename "$f" .1).html" "$f"
	done

# Remove all build artifacts and cloned sources
clean:
	@rm -rf .ext .man build public resources .hugo_build.lock
