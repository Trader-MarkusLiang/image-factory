#!/usr/bin/env bash
set -euo pipefail

FACTORY_DIR="${STORY_IMAGE_FACTORY:-/Users/markus/AI/image-factory}"
COMFYUI_DIR="${FACTORY_DIR}/ComfyUI"
PYTHON_BIN="${PYTHON_BIN:-/opt/homebrew/bin/python3.11}"

if [[ ! -x "${PYTHON_BIN}" ]]; then
  PYTHON_BIN="$(command -v python3)"
fi

if [[ -f "${COMFYUI_DIR}/main.py" ]]; then
  echo "ComfyUI already exists at ${COMFYUI_DIR}"
else
  rm -rf "${COMFYUI_DIR}"
  git clone --depth 1 https://github.com/comfyanonymous/ComfyUI.git "${COMFYUI_DIR}"
fi

cd "${COMFYUI_DIR}"
"${PYTHON_BIN}" -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip setuptools wheel
python -m pip install -r requirements.txt

cat > "${FACTORY_DIR}/scripts/start_comfyui_venv.sh" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

FACTORY_DIR="${STORY_IMAGE_FACTORY:-/Users/markus/AI/image-factory}"
COMFYUI_DIR="${FACTORY_DIR}/ComfyUI"

cd "${COMFYUI_DIR}"
source .venv/bin/activate
exec python main.py --listen 127.0.0.1 --port 8188
EOF
chmod +x "${FACTORY_DIR}/scripts/start_comfyui_venv.sh"

echo "ComfyUI installed at ${COMFYUI_DIR}"
echo "Start it with: ${FACTORY_DIR}/scripts/start_comfyui_venv.sh"

