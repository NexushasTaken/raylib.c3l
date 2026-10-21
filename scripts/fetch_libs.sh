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

VERSION="6.2"
BASE_URL="https://github.com/raysan5/raylib/releases/download/$VERSION"

# c3 target | release asset | sha256 of the asset | library inside lib/ | sha256 of the library | installed as
ASSETS="
linux-x64     linux_amd64.tar.gz  586bbc32f3596d439382b1c5dbc6c1c573eb7e1d00fe92be7d4deb116883720d libraylib.a     f0ac4cc3e9c1ceadae4ef6ead1f41a235ec333c5af21aa64aebd173c3b9dbcb1 libraylib.a
macos-x64     macos.tar.gz        100437734a44d56ed9d2a1c4b249dbfc6d6cc3477a45e306f9f56fe5f1e2b4ef libraylib.a     8b0c2a190adf0af2c5b176c041c2357bda3b13e2cacb4db6c00fe1d8da1c4c00 libraylib.a
macos-aarch64 macos.tar.gz        100437734a44d56ed9d2a1c4b249dbfc6d6cc3477a45e306f9f56fe5f1e2b4ef libraylib.a     8b0c2a190adf0af2c5b176c041c2357bda3b13e2cacb4db6c00fe1d8da1c4c00 libraylib.a
windows-x64   win64_msvc16.zip    8467b5dd6db4d7ab942f3148a3d30d93be6ed9b2fab88069d177e59604268ebd raylib.lib      e50c66cf2521659f6f866247858cbcbb256a4ac8e45a547b9179b5e204ce730d raylib.lib
mingw-x64     win64_mingw-w64.zip 48ba378d100fe7e13fc2c35d708764b855b815596f3b0a31746e37259283961f libraylib.a     ad05e94109e7690a07f8b8d9baa11025f809c3429e0d4252b36382db7f35dbe9 libraylib.a
wasm32        webassembly.zip     5f77e0cc3f92de2c932e8b69c0b5adfe6d4afde1d313ee075133a5a3ca92e76c libraylib.web.a a6bd883872b6d2c528ca4068d3e6d6377ffc8b332357c54d36f8d894547d8840 libraylib.a
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

echo "$ASSETS" | while read -r target asset sum lib libsum dst; do
	[ -n "$target" ] || continue
	wanted "$target" || continue

	dest="$ROOT/libs/$target/$dst"
	if [ -f "$dest" ] && [ "$(sha256 "$dest")" = "$libsum" ]; then
		echo "libs/$target/$dst is up to date"
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
	echo "  -> libs/$target/$dst"
done
