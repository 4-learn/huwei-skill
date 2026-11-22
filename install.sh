#!/usr/bin/env bash
# 安裝到 DSH 站台：bash install.sh  （在站台 agent 的 bash 裡跑）
set -euo pipefail
SRC="$(cd "$(dirname "$0")" && pwd)/huwei"
DST="${DSH_HOME:?DSH_HOME 未設定}/skills/huwei"
mkdir -p "$DST"
# 程式與說明書每次覆蓋；相簿裡同學加的照片（u-*）保留
cp "$SRC/SKILL.md" "$SRC/huwei.mjs" "$SRC/package.json" "$DST/"
mkdir -p "$DST/data"
for d in exam calib; do mkdir -p "$DST/data/$d"; cp -rn "$SRC/data/$d/." "$DST/data/$d/"; done
# 相簿：瘦身中（有 album-full 備份）就只更新備份，不動上課用的相簿
if [ -d "$DST/data/album-full" ]; then cp -rn "$SRC/data/album/." "$DST/data/album-full/"; echo "（相簿瘦身中，只更新 album-full）"
else mkdir -p "$DST/data/album"; cp -rn "$SRC/data/album/." "$DST/data/album/"; fi
cp "$SRC/data/CREDITS.md" "$DST/data/"
# 範例人設 skill（已存在就不覆蓋，避免蓋掉同學改過的版本）
for ex in "$(dirname "$SRC")"/examples/*/; do n=$(basename "$ex"); [ -d "${DSH_HOME}/skills/$n" ] || cp -r "$ex" "${DSH_HOME}/skills/$n"; done
cd "$DST" && npm install --silent --no-audit --no-fund
echo "✅ 裝好了：$DST"
node "$DST/huwei.mjs" album
