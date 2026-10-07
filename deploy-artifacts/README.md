# 9Router standalone runtime for Botkeep

This branch contains a prebuilt standalone runtime for the `9r` Botkeep deployment. It is intentionally separate from `main` and is based on source commit `d24d98a16265fece9c23b1982febca0c1d17b0b2`.

## Artifact

- File: `9r-standalone-runtime-d24d98a.tar.gz`
- Compressed size: 52,787,477 bytes
- SHA-256: `b26dfe99645624d075e67b93df098c5457aeedc77942d395fae53101b086b574`
- Extracted size: 162,710,458 bytes (about 155.2 MiB)
- Runtime: Node.js 22; prebuilt Next.js standalone server and bundled `node_modules`
- Entry points: `custom-server.js` and `server.js`; Next build marker: `.next/BUILD_ID`
- The archive was checked to contain no `.env`, `.9router`, or user-state files.

## Botkeep contract

Use Botkeep's actual container root (`/home/container`), honor the runtime `SERVER_PORT`, and bind to `0.0.0.0`. Extract into a new release directory such as `/home/container/9r-standalone-d24d98a`; preserve the existing `/home/container/app`, `.env`, `.9router`, and other state. Do not run `npm ci`, `npm install`, or a build on Botkeep storage: the standalone artifact already includes its runtime dependencies. Set `DATA_DIR=/home/container/.9router` and `NODE_ENV=production` when launching `node custom-server.js --port "$SERVER_PORT" --hostname 0.0.0.0`.

The public raw artifact URL for this branch is:

`https://raw.githubusercontent.com/akunpindo55/9r-deploy/deploy/standalone-runtime-20261007/deploy-artifacts/9r-standalone-runtime-d24d98a.tar.gz`
