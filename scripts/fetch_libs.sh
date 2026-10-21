#!/bin/sh
# Download the prebuilt raylib static libraries from the official GitHub
# release and put them in libs/<c3 target>/.
#
# Only release assets that match a supported C3 target are fetched. The win32
# builds are skipped (C3 has no 32-bit Windows target), and so is linux_i386
# (c3c reports linux-x86 as unsupported). raylib has no FreeBSD release, so
# libs/freebsd-x64 is left as is.
#
# A library whose sha256 already matches the one below is not downloaded again.
# The hashes are pinned here because GitHub has no digests for these assets.
#
# Usage: scripts/fetch_libs.sh [target...]   (default: all targets below)
set -eu

VERSION="5.5"
BASE_URL="https://github.com/raysan5/raylib/releases/download/$VERSION"

# c3 target | release asset | sha256 of the asset | library inside lib/ | sha256 of the library
ASSETS="
linux-x64     linux_amd64.tar.gz  3d95ef03d5b38dfa55c0a16ca122d382134b078f0e5b270b52fe7eae0549c000 libraylib.a 3323cbf14ec6e640e19d63e230e68c3a530be3e9a9d416435eab82160e9e9ccc
macos-x64     macos.tar.gz        930c67b676963c6cffbd965814664523081ecbf3d30fc9df4211d0064aa6ba39 libraylib.a 5517f19555ce6e19540ac534bb5d5bf08ba45660d14642db4878f079a9f1b7da
macos-aarch64 macos.tar.gz        930c67b676963c6cffbd965814664523081ecbf3d30fc9df4211d0064aa6ba39 libraylib.a 5517f19555ce6e19540ac534bb5d5bf08ba45660d14642db4878f079a9f1b7da
windows-x64   win64_msvc16.zip    8d046084d12353183e701ef4c9d276c21fcd3243c2a368091fabfb2769b8507c raylib.lib  b4c0dc0d3999f528f298fa41eb1f72092b49aafc43cf98a65926518eb7137c43
mingw-x64     win64_mingw-w64.zip fe8feda1b92fc02826e2d19c631d648fd0563b93b144893fe18140e9fe4fb6fd libraylib.a 434e2475f3b74ca625e49eada239b3a5dca79f5c468d2ff82820ffa0791ceff9
wasm32        webassembly.zip     798b6bea650e78a60fe49f106a15d92ea4e33efd3aa1b3efa34b0438a14bbf2c libraylib.a ea2ff8be3fbce064de83788784d5b7742c7fbb14c5a09bfdd20e9ea95e312764
"

ROOT=$(cd "$(dirname "$0")/.." && pwd)
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

sha256() {
	if command -v sha256sum >/dev/null 2>&1; then
		sha256sum "$1" | cut -d' ' -f1
	else
		shasum -a 256 "$1" | cut -d' ' -f1 # macOS
	fi
}

wanted() {
	[ -z "$TARGETS" ] && return 0
	for t in $TARGETS; do
		[ "$t" = "$1" ] && return 0
	done
	return 1
}

TARGETS="$*"
for t in $TARGETS; do
	echo "$ASSETS" | grep -q "^$t " || { echo "unknown target: $t" >&2; exit 1; }
done

echo "$ASSETS" | while read -r target asset sum lib libsum; do
	[ -n "$target" ] || continue
	wanted "$target" || continue

	dest="$ROOT/libs/$target/$lib"
	if [ -f "$dest" ] && [ "$(sha256 "$dest")" = "$libsum" ]; then
		echo "libs/$target/$lib is up to date"
		continue
	fi

	name="raylib-${VERSION}_${asset%%.*}"
	archive="$TMP/$asset"

	# The macOS asset is shared by two targets, so only download it once
	if [ ! -f "$archive" ]; then
		echo "downloading $name"
		curl -fsSL -o "$archive" "$BASE_URL/raylib-${VERSION}_$asset"
		actual=$(sha256 "$archive")
		if [ "$actual" != "$sum" ]; then
			echo "checksum mismatch for $asset: expected $sum, got $actual" >&2
			exit 1
		fi
		case "$asset" in
			*.tar.gz) tar -xzf "$archive" -C "$TMP" ;;
			*.zip) unzip -qo "$archive" -d "$TMP" ;;
		esac
	fi

	actual=$(sha256 "$TMP/$name/lib/$lib")
	if [ "$actual" != "$libsum" ]; then
		echo "checksum mismatch for $name/lib/$lib: expected $libsum, got $actual" >&2
		exit 1
	fi

	mkdir -p "$ROOT/libs/$target"
	cp "$TMP/$name/lib/$lib" "$dest"
	echo "  -> libs/$target/$lib"
done
