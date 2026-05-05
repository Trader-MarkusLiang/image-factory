# Setup

This repository stores the local image factory management layer only.

It intentionally does not commit:

- ComfyUI runtime source checkout
- Python virtual environments
- model weights
- generated outputs
- caches

## Install ComfyUI

```bash
/Users/markus/AI/image-factory/scripts/install_comfyui.sh
```

If GitHub clone is slow, download a ComfyUI zipball manually or rerun the script later.

## Start

```bash
/Users/markus/AI/image-factory/scripts/start_comfyui_venv.sh
```

## Health Check

```bash
/Users/markus/AI/image-factory/scripts/healthcheck.sh
```

## Download Models

Use China-friendly download strategy:

```bash
export HF_ENDPOINT=https://hf-mirror.com
export HF_HUB_ENABLE_HF_TRANSFER=1
/Users/markus/AI/image-factory/scripts/download_first_batch.sh
```

Model state is tracked in:

```text
docs/model-inventory.md
```

