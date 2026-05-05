#!/usr/bin/env bash
set -euo pipefail
FACTORY_DIR="${STORY_IMAGE_FACTORY:-/Users/markus/AI/image-factory}"
COMFYUI_DIR="${FACTORY_DIR}/ComfyUI"
cd "${COMFYUI_DIR}"
source .venv/bin/activate
exec python main.py --listen 127.0.0.1 --port 8188
