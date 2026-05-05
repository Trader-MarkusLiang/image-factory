#!/usr/bin/env bash
set -euo pipefail

COMFYUI_URL="${STORY_COMFYUI_URL:-http://127.0.0.1:8188}"
curl -fsS "${COMFYUI_URL}/system_stats"
printf '\n'

