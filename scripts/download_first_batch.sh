#!/usr/bin/env bash
set -euo pipefail

FACTORY_DIR="${STORY_IMAGE_FACTORY:-/Users/markus/AI/image-factory}"
DL="${FACTORY_DIR}/scripts/download_model.sh"
SOURCE="${STORY_MODEL_DOWNLOAD_SOURCE:-hf-mirror}"

mkdir -p \
  "${FACTORY_DIR}/models/checkpoints" \
  "${FACTORY_DIR}/models/vae" \
  "${FACTORY_DIR}/models/controlnet" \
  "${FACTORY_DIR}/models/ipadapter" \
  "${FACTORY_DIR}/models/clip_vision" \
  "${FACTORY_DIR}/models/upscale_models" \
  "${FACTORY_DIR}/models/diffusion_models"

download_hf() {
  local repo="$1"
  local filename="$2"
  local local_dir="$3"
  "${DL}" --source "${SOURCE}" --repo "${repo}" --filename "${filename}" --local-dir "${local_dir}"
}

echo "Downloading Priority A: SDXL base checkpoint"
download_hf "stabilityai/stable-diffusion-xl-base-1.0" "sd_xl_base_1.0.safetensors" "${FACTORY_DIR}/models/checkpoints"

echo "Downloading Priority A: SDXL fp16 VAE"
download_hf "madebyollin/sdxl-vae-fp16-fix" "diffusion_pytorch_model.safetensors" "${FACTORY_DIR}/models/vae"
if [[ -f "${FACTORY_DIR}/models/vae/diffusion_pytorch_model.safetensors" ]]; then
  cp -n "${FACTORY_DIR}/models/vae/diffusion_pytorch_model.safetensors" "${FACTORY_DIR}/models/vae/sdxl_vae_fp16_fix.safetensors"
fi

echo "Downloading Priority B: SDXL ControlNet Canny"
"${DL}" --source "${SOURCE}" --repo "xinsir/controlnet-canny-sdxl-1.0" --include "*.safetensors" --local-dir "${FACTORY_DIR}/models/controlnet/xinsir-controlnet-canny-sdxl-1.0"

echo "Downloading Priority B: SDXL ControlNet OpenPose"
"${DL}" --source "${SOURCE}" --repo "xinsir/controlnet-openpose-sdxl-1.0" --include "*.safetensors" --local-dir "${FACTORY_DIR}/models/controlnet/xinsir-controlnet-openpose-sdxl-1.0"

echo "Downloading Priority B: SDXL ControlNet Depth"
"${DL}" --source "${SOURCE}" --repo "xinsir/controlnet-depth-sdxl-1.0" --include "*.safetensors" --local-dir "${FACTORY_DIR}/models/controlnet/xinsir-controlnet-depth-sdxl-1.0"

echo "Downloading Priority B: IPAdapter SDXL"
download_hf "h94/IP-Adapter" "sdxl_models/ip-adapter-plus_sdxl_vit-h.safetensors" "${FACTORY_DIR}/models/ipadapter"
download_hf "h94/IP-Adapter" "sdxl_models/image_encoder/model.safetensors" "${FACTORY_DIR}/models/clip_vision"

echo "First batch download attempted. Review docs/model-inventory.md and actual files."

