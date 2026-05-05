#!/usr/bin/env bash
set -euo pipefail

FACTORY_DIR="${STORY_IMAGE_FACTORY:-/Users/markus/AI/image-factory}"
COMFYUI_DIR="${FACTORY_DIR}/ComfyUI"

if [[ ! -f "${COMFYUI_DIR}/main.py" ]]; then
  echo "ComfyUI is not installed at ${COMFYUI_DIR}."
  echo "Install ComfyUI first, then rerun this script."
  exit 1
fi

cd "${COMFYUI_DIR}"
exec python3 main.py --listen 127.0.0.1 --port 8188

