#!/usr/bin/env bash
set -euo pipefail

FACTORY_DIR="${STORY_IMAGE_FACTORY:-/Users/markus/AI/image-factory}"
SOURCE="hf-mirror"
REPO_ID=""
FILENAME=""
INCLUDE=""
LOCAL_DIR=""
URL=""

usage() {
  cat <<'EOF'
Usage:
  download_model.sh --source hf-mirror --repo owner/model --filename file.safetensors --local-dir /path
  download_model.sh --source hf-mirror --repo owner/model --include "*.safetensors" --local-dir /path
  download_model.sh --source hf --repo owner/model --filename file.safetensors --local-dir /path
  download_model.sh --source modelscope --repo owner/model --filename file.safetensors --local-dir /path
  download_model.sh --source url --url https://example/file.safetensors --local-dir /path

Sources:
  hf-mirror   Hugging Face CLI through https://hf-mirror.com
  hf          Hugging Face official endpoint
  modelscope  ModelScope CLI
  url         curl direct download
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --source)
      SOURCE="$2"
      shift 2
      ;;
    --repo)
      REPO_ID="$2"
      shift 2
      ;;
    --filename)
      FILENAME="$2"
      shift 2
      ;;
    --include)
      INCLUDE="$2"
      shift 2
      ;;
    --local-dir)
      LOCAL_DIR="$2"
      shift 2
      ;;
    --url)
      URL="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1"
      usage
      exit 2
      ;;
  esac
done

if [[ -z "${LOCAL_DIR}" ]]; then
  echo "Missing --local-dir"
  usage
  exit 2
fi

mkdir -p "${LOCAL_DIR}"

case "${SOURCE}" in
  hf-mirror|hf)
    if [[ -z "${REPO_ID}" ]]; then
      echo "Missing --repo for ${SOURCE}"
      exit 2
    fi
    if ! command -v hf >/dev/null 2>&1 && ! command -v huggingface-cli >/dev/null 2>&1; then
      echo "Missing Hugging Face CLI. Install with:"
      echo "  python3 -m pip install -U huggingface_hub"
      exit 1
    fi
    HF_CMD="$(command -v hf || command -v huggingface-cli)"
    if [[ "${SOURCE}" == "hf-mirror" ]]; then
      export HF_ENDPOINT="${HF_ENDPOINT:-https://hf-mirror.com}"
    fi
    export HF_HUB_OFFLINE=0
    export HF_HUB_ENABLE_HF_TRANSFER="${HF_HUB_ENABLE_HF_TRANSFER:-1}"
    if [[ -n "${FILENAME}" ]]; then
      "${HF_CMD}" download "${REPO_ID}" "${FILENAME}" --local-dir "${LOCAL_DIR}"
    elif [[ -n "${INCLUDE}" ]]; then
      "${HF_CMD}" download "${REPO_ID}" --include "${INCLUDE}" --local-dir "${LOCAL_DIR}"
    else
      "${HF_CMD}" download "${REPO_ID}" --local-dir "${LOCAL_DIR}"
    fi
    ;;
  modelscope)
    if [[ -z "${REPO_ID}" ]]; then
      echo "Missing --repo for modelscope"
      exit 2
    fi
    if ! command -v modelscope >/dev/null 2>&1; then
      echo "Missing ModelScope CLI. Install with:"
      echo "  python3 -m pip install -U modelscope"
      exit 1
    fi
    if [[ -n "${FILENAME}" ]]; then
      modelscope download --model "${REPO_ID}" "${FILENAME}" --local_dir "${LOCAL_DIR}"
    else
      modelscope download --model "${REPO_ID}" --local_dir "${LOCAL_DIR}"
    fi
    ;;
  url)
    if [[ -z "${URL}" ]]; then
      echo "Missing --url for url source"
      exit 2
    fi
    BASENAME="${FILENAME:-$(basename "${URL%%\?*}")}"
    curl -L --fail --retry 8 --retry-delay 5 --continue-at - "${URL}" -o "${LOCAL_DIR}/${BASENAME}"
    ;;
  *)
    echo "Unsupported source: ${SOURCE}"
    usage
    exit 2
    ;;
esac

echo "Downloaded into ${LOCAL_DIR}"
