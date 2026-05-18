#!/usr/bin/env nix-shell
#!nix-shell -i bash -p bash cacert curl jq nix unzip
set -euo pipefail

cd "$(dirname "$(readlink -f "$0")")/../../.."
FILE="nix/packages/osu-lazer-bin/default.nix"

echo "Fetching latest releases from GitHub..."
releases="$(curl -s "https://api.github.com/repos/ppy/osu/releases")"

lazer_tag="$(echo "$releases" | jq -r 'map(select(.tag_name | endswith("-lazer"))) | .[0].tag_name')"
tachyon_tag="$(echo "$releases" | jq -r 'map(select(.tag_name | endswith("-tachyon"))) | .[0].tag_name')"

update_channel() {
    local channel="$1"
    local tag="$2"
    local version="${tag%-$channel}"
    
    local old_version=$(grep -A 10 "$channel = {" "$FILE" | grep "version =" | head -n1 | cut -d'"' -f2)

    if [[ "$version" == "$old_version" ]]; then
        echo "$channel is already up to date ($version)."
        return 0
    fi

    echo "Updating $channel from $old_version to $version..."
    
    # Update version in the specific block
    sed -i "/$channel = {/,/};/ s/version = \".*\";/version = \"$version\";/" "$FILE"

    for pair in \
        'aarch64-darwin osu.app.Apple.Silicon.zip' \
        'x86_64-darwin osu.app.Intel.zip' \
        'x86_64-linux osu.AppImage'
    do
        set -- $pair
        echo "Prefetching $channel binary for $1..."
        prefetch_output=$(nix --extra-experimental-features "nix-command flakes" store prefetch-file --json --hash-type sha256 "https://github.com/ppy/osu/releases/download/$tag/$2")
        
        if [[ "$1" == *"darwin"* ]]; then
            store_path=$(jq -r '.storePath' <<<"$prefetch_output")
            tmpdir=$(mktemp -d)
            unzip -q "$store_path" -d "$tmpdir"
            hash=$(nix --extra-experimental-features "nix-command flakes" hash path "$tmpdir")
            rm -r "$tmpdir"
        else
            hash=$(jq -r '.hash' <<<"$prefetch_output")
        fi
        echo "$1 ($2): hash = $hash"

        # Update hash for the specific system in the channel block
        # We use the system name as the key in the attrset
        sed -i "/$channel = {/,/};/ s|$1 = \".*\";|$1 = \"$hash\";|" "$FILE"
    done
}

update_channel "lazer" "$lazer_tag"
update_channel "tachyon" "$tachyon_tag"
