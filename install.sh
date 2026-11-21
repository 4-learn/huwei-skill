#!/usr/bin/env bash
# 安裝到 DSH 站台：bash install.sh  （在站台 agent 的 bash 裡跑）
set -euo pipefail
SRC="$(cd "$(dirname "$0")" && pwd)/huwei"
DST="${DSH_HOME:?DSH_HOME 未設定}/skills/huwei"
mkdir -p "$DST"
# 程式與說明書每次覆蓋；相簿裡同學加的照片（u-*）保留
cp "$SRC/SKILL.md" "$SRC/huwei.mjs" "$SRC/package.json" "$DST/"
mkdir -p "$DST/data"
for d in album exam calib; do mkdir -p "$DST/data/$d"; cp -rn "$SRC/data/$d/." "$DST/data/$d/"; done
cp "$SRC/data/CREDITS.md" "$DST/data/"
cd "$DST" && npm install --silent --no-audit --no-fund
echo "✅ 裝好了：$DST"
node "$DST/huwei.mjs" album
