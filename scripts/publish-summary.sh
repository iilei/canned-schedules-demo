#!/usr/bin/env bash
# The demo's post-fetch script: it lists what would be uploaded in the job summary. A real catalog uploads here,
# e.g. with the S3 or Artifactory loop from the companion's README, and fails when the upload fails.
set -euo pipefail
cd "$1"
{
  printf '### Published schedules\n\n| Schedule | Folder | Reviewed | Digest |\n| --- | --- | --- | --- |\n'
  jq -r '.schedules[] | "| \(.name) | `\(.dir)` | \(if .reviewed then "yes" else "no (\(.reason))" end) | `\(.digest)` |"' \
    manifest.json
} >> "${GITHUB_STEP_SUMMARY:-/dev/stdout}"
