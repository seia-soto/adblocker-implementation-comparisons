#!/bin/zsh
[[ "$DEBUG" != "" ]] && set -x

OUTFILE="$1"

[[ "$OUTFILE" == "" ]] && echo "The first argument 'OUTFILE' must be provided!" && exit 1

function exists() {
  local CMD="$1"
  [[ "$(which "$CMD")" == "" ]] && echo "$CMD is required but not installed!" && exit 1
}

function fetch() {
  local URL="$1"
  echo "* Fetching '$URL'"
  echo "! $URL\n" >> "$OUTFILE"
  curl -sL --max-redirs 5 -m 60 --retry 5 --retry-delay 5 --retry-max-time 120 "$URL" >> "$OUTFILE"
  echo '\n\n' >> "$OUTFILE"
}

function fetch_ghostery() {
  fetch 'https://ghostery.github.io/broken-page-reports/filters.txt'
  fetch 'https://github.com/ghostery/trackerdb/releases/latest/download/trackerdb.txt'
}

function fetch_adguard() {
  fetch 'https://filters.adtidy.org/extension/chromium/filters/11.txt'
}

function fetch_ubo() {
  fetch 'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt'
  fetch 'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters-2020.txt'
  fetch 'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters-2021.txt'
  fetch 'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters-2022.txt'
  fetch 'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters-2023.txt'
  fetch 'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters-2024.txt'
  fetch 'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt'
  fetch 'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt'
  fetch 'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/quick-fixes.txt'
  fetch 'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/resource-abuse.txt'
  fetch 'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances-cookies.txt'
  fetch 'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/annoyances-others.txt'
  fetch 'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt'
}

function fetch_easylist() {
  fetch 'https://easylist.to/easylist/easylist.txt'
  fetch 'https://easylist.to/easylist/easyprivacy.txt'
  fetch 'https://secure.fanboy.co.nz/fanboy-cookiemonster_ubo.txt'
}

function fetch_peter_lowe() {
  fetch 'https://pgl.yoyo.org/adservers/serverlist.php?hostformat=adblockplus&showintro=0&mimetype=plaintext'
}

function fetch_regional() {
  fetch 'https://easylist-downloads.adblockplus.org/Liste_AR.txt'
  fetch 'https://stanev.org/abp/adblock_bg.txt'
  fetch 'https://easylist.to/easylistgermany/easylistgermany.txt'
  fetch 'https://easylist-downloads.adblockplus.org/liste_fr.txt'
  fetch 'https://www.void.gr/kargig/void-gr-filters.txt'
  fetch 'https://cdn.jsdelivr.net/gh/hufilter/hufilter@gh-pages/hufilter.txt'
  fetch 'https://easylist-downloads.adblockplus.org/easylistitaly.txt'
  fetch 'https://filters.adtidy.org/extension/ublock/filters/7.txt'
  fetch 'https://github.com/yous/YousList/raw/master/youslist.txt'
  fetch 'https://easylist-downloads.adblockplus.org/easylistpolish.txt'
  fetch 'https://easylist-downloads.adblockplus.org/advblock+cssfixes.txt'
  fetch 'https://filters.adtidy.org/extension/chromium/filters/13.txt'
  fetch 'https://raw.githubusercontent.com/heradhis/indonesianadblockrules/master/subscriptions/abpindo.txt'
  fetch 'https://abpvn.com/filter/abpvn-IPl6HE.txt'
  fetch 'https://raw.githubusercontent.com/DandelionSprout/adfilt/master/NorwegianExperimentalList%20alternate%20versions/NordicFiltersABP-Inclusion.txt'
  fetch 'https://easylist-downloads.adblockplus.org/easylistchina.txt'
  fetch 'https://raw.githubusercontent.com/tomasko126/easylistczechandslovak/master/filters.txt'
  fetch 'https://easylist-downloads.adblockplus.org/easylistdutch.txt'
  fetch 'https://raw.githubusercontent.com/easylist/EasyListHebrew/master/EasyListHebrew.txt'
  fetch 'https://raw.githubusercontent.com/EasyList-Lithuania/easylist_lithuania/master/easylistlithuania.txt'
  fetch 'https://easylist-downloads.adblockplus.org/easylistportuguese.txt'
  fetch 'https://easylist-downloads.adblockplus.org/easylistspanish.txt'
  fetch 'https://easylist-downloads.adblockplus.org/indianlist.txt'
  fetch 'https://raw.githubusercontent.com/Latvian-List/adblock-latvian/master/lists/latvian-list.txt'
  fetch 'https://www.zoso.ro/pages/rolist.txt'
  fetch 'https://raw.githubusercontent.com/MasterKia/PersianBlocker/main/PersianBlocker.txt'
}

exists 'curl'

mkdir -p ./data
echo "! Generation date: $(date)" > "$OUTFILE"

[[ "$SKIP_FILTER_GHOSTERY" == "" ]] && fetch_ghostery
[[ "$SKIP_FILTER_ADGUARD" == "" ]] && fetch_adguard
[[ "$SKIP_FILTER_UBLOCKORIGIN" == "" ]] && fetch_ubo
[[ "$SKIP_FILTER_EASYLIST" == "" ]] && fetch_easylist
[[ "$SKIP_FILTER_PETERLOWE" == "" ]] && fetch_peter_lowe
[[ "$SKIP_FILTER_REGIONAL" == "" ]] && fetch_regional
