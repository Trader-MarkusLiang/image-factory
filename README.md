# Image Factory

Local image and video generation factory for comic production.

This directory is intentionally outside the comic content project. It stores local model runtimes, model weights, ComfyUI workflows, cache files, and temporary outputs.

Primary content project:

```text
/Users/markus/Documents/New project/
```

Recommended service URL:

```text
http://127.0.0.1:8188
```

## Layout

```text
ComfyUI/
models/
workflows/
inputs/
outputs/
cache/
logs/
scripts/
docs/
```

## First Milestone

1. Install ComfyUI into `ComfyUI/`.
2. Place SDXL model files under `models/checkpoints/`.
3. Add a working `workflows/sdxl_panel.json`.
4. Start ComfyUI on `127.0.0.1:8188`.
5. Run the content project's `pipeline/scripts/generate_image_local.py`.

## Install

Run:

```bash
/Users/markus/AI/image-factory/scripts/install_comfyui.sh
```

If GitHub is slow, rerun the same command later. The script uses a shallow clone.

After install:

```bash
/Users/markus/AI/image-factory/scripts/start_comfyui_venv.sh
```

Health check:

```bash
/Users/markus/AI/image-factory/scripts/healthcheck.sh
```

## Model Downloads

For China mainland networks, prefer ModelScope or HF-Mirror:

```bash
/Users/markus/AI/image-factory/scripts/download_model.sh \
  --source hf-mirror \
  --repo owner/model \
  --filename model.safetensors \
  --local-dir /Users/markus/AI/image-factory/models/checkpoints
```

See:

```text
docs/download-strategy.md
docs/model-inventory.md
```
