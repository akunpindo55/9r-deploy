#!/bin/sh
set -eu
BASE=/home/container
ARCHIVE="$BASE/9r-standalone-runtime-d24d98a.tar.gz"
PART="$BASE/.9r-runtime-download-d24d98a.part"
STAGE="$BASE/.9r-runtime-stage-d24d98a"
RELEASE="$BASE/9r-standalone-d24d98a"
URL="https://raw.githubusercontent.com/akunpindo55/9r-deploy/deploy/standalone-runtime-20261007/deploy-artifacts/9r-standalone-runtime-d24d98a.tar.gz"
EXPECTED="b26dfe99645624d075e67b93df098c5457aeedc77942d395fae53101b086b574"

test ! -e "$ARCHIVE"
test ! -e "$PART"
test ! -e "$STAGE"
test ! -e "$RELEASE"

node -e 'const fs=require("node:fs"),{Readable}=require("node:stream"),{pipeline}=require("node:stream/promises");(async()=>{const r=await fetch(process.argv[1]);if(!r.ok||!r.body)throw new Error("HTTP "+r.status);await pipeline(Readable.fromWeb(r.body),fs.createWriteStream(process.argv[2],{flags:"wx"}));})().catch(e=>{console.error("artifact download failed:",e.message);process.exit(1)})' "$URL" "$PART"
node -e 'const fs=require("node:fs"),crypto=require("node:crypto");(async()=>{const h=crypto.createHash("sha256");let bytes=0;for await(const b of fs.createReadStream(process.argv[1])){h.update(b);bytes+=b.length;}if(h.digest("hex")!==process.argv[2]||bytes!==52787477)throw new Error("artifact checksum/size mismatch");})().catch(e=>{console.error("artifact verification failed:",e.message);process.exit(1)})' "$PART" "$EXPECTED"

mv "$PART" "$ARCHIVE"
mkdir "$STAGE"
tar -xzf "$ARCHIVE" -C "$STAGE"
test -f "$STAGE/custom-server.js"
test -f "$STAGE/server.js"
test -f "$STAGE/.next/BUILD_ID"
test -d "$STAGE/node_modules"
mv "$STAGE" "$RELEASE"
cd "$RELEASE"
export NODE_ENV=production
export HOSTNAME=0.0.0.0
export DATA_DIR="$BASE/.9router"
export PORT="${SERVER_PORT:?SERVER_PORT is required}"
exec node custom-server.js --port "$PORT" --hostname 0.0.0.0
