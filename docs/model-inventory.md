# Model Inventory

This file tracks local model files used by the comic production pipeline.

Do not copy model weights into the content project.

## SDXL Main Production

| Role | File | Status | Notes |
| --- | --- | --- | --- |
| SDXL checkpoint | `ComfyUI/models/checkpoints/sd_xl_base_1.0.safetensors` | installed | Main panel generation; smoke tested on MPS |
| SDXL VAE | `ComfyUI/models/vae/sdxl_vae_fp16_fix.safetensors` | installed | Also kept as `diffusion_pytorch_model.safetensors` |
| SDXL inpaint | `models/checkpoints/` | pending | Local repair workflow |

## ControlNet

| Role | File | Status | Notes |
| --- | --- | --- | --- |
| OpenPose | `ComfyUI/models/controlnet/xinsir-controlnet-openpose-sdxl-1.0/` | installed | Pose control; includes base and twins safetensors |
| Lineart/Canny | `ComfyUI/models/controlnet/xinsir-controlnet-canny-sdxl-1.0/` | installed | Composition control; includes base and V2 safetensors |
| Depth | `ComfyUI/models/controlnet/xinsir-controlnet-depth-sdxl-1.0/` | installed | Scene depth |

## Reference And Consistency

| Role | File | Status | Notes |
| --- | --- | --- | --- |
| IPAdapter | `ComfyUI/models/ipadapter/` | partial | HF-Mirror download was very slow; interrupted after partial cache |
| Lin Yan LoRA | `models/loras/` | pending | Character lock |

## Keyframes And Text

| Role | File | Status | Notes |
| --- | --- | --- | --- |
| FLUX | `models/diffusion_models/` | pending | Opening images and keyframes |
| Qwen-Image | `models/diffusion_models/` | pending | Chinese-heavy images |
| Qwen-Image-Edit | `models/diffusion_models/` | pending | Semantic image editing |

## Video Experiments

| Role | File | Status | Notes |
| --- | --- | --- | --- |
| Wan / Hunyuan / LTX | TBD | pending | Experimental only |

## Smoke Tests

| Date | Test | Result | Output |
| --- | --- | --- | --- |
| 2026-05-05 | SDXL base through ComfyUI MPS API, 512x768 | passed | `/Users/markus/AI/image-factory/outputs/sdxl_smoke.png` |

## Download Source Policy

Preferred order:

```text
ModelScope
-> HF-Mirror with HF_ENDPOINT=https://hf-mirror.com
-> Hugging Face official
-> Direct trusted URL
```

Use:

```bash
/Users/markus/AI/image-factory/scripts/download_model.sh
```

Record actual repo id, filename, source, license, and date after each download.
