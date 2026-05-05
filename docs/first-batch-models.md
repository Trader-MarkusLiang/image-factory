# First Batch Models

This is the deploy-and-test batch. It is intentionally smaller than the final wish list so the local pipeline can reach a working smoke test before downloading every large experimental model.

## Priority A: SDXL Main Production

| Task | Source | Repo | Files | Destination | Status |
| --- | --- | --- | --- | --- | --- |
| Base SDXL checkpoint | HF-Mirror | `stabilityai/stable-diffusion-xl-base-1.0` | `sd_xl_base_1.0.safetensors` | `models/checkpoints/` | pending |
| SDXL VAE | HF-Mirror | `madebyollin/sdxl-vae-fp16-fix` | `diffusion_pytorch_model.safetensors` | `models/vae/` | pending |
| Comic/anime SDXL checkpoint | HF-Mirror | `cagliostrolab/animagine-xl-4.0` | `animagine-xl-4.0.safetensors` or available safetensors | `models/checkpoints/` | pending |

## Priority B: Control And Reference

| Task | Source | Repo | Files | Destination | Status |
| --- | --- | --- | --- | --- | --- |
| SDXL Canny ControlNet | HF-Mirror | `xinsir/controlnet-canny-sdxl-1.0` | safetensors | `models/controlnet/` | pending |
| SDXL OpenPose ControlNet | HF-Mirror | `xinsir/controlnet-openpose-sdxl-1.0` | safetensors | `models/controlnet/` | pending |
| SDXL Depth ControlNet | HF-Mirror | `xinsir/controlnet-depth-sdxl-1.0` | safetensors | `models/controlnet/` | pending |
| IPAdapter SDXL | HF-Mirror | `h94/IP-Adapter` | `sdxl_models/ip-adapter-plus_sdxl_vit-h.safetensors` | `models/ipadapter/` | pending |
| CLIP Vision for IPAdapter | HF-Mirror | `h94/IP-Adapter` | `sdxl_models/image_encoder/model.safetensors` | `models/clip_vision/` | pending |

## Priority C: Repair And Upscale

| Task | Source | Repo | Files | Destination | Status |
| --- | --- | --- | --- | --- | --- |
| Upscale model | HF-Mirror or direct trusted URL | TBD | `.pth` / `.safetensors` | `models/upscale_models/` | pending |
| SDXL inpaint | HF-Mirror | TBD | safetensors | `models/checkpoints/` | pending |

## Priority D: Keyframe / Chinese / Video Experiments

| Task | Source | Repo | Files | Destination | Status |
| --- | --- | --- | --- | --- | --- |
| FLUX Schnell | HF-Mirror | `black-forest-labs/FLUX.1-schnell` | diffusers safetensors | `models/diffusion_models/flux1-schnell/` | pending |
| Qwen-Image | ModelScope or HF-Mirror | TBD | model files | `models/diffusion_models/qwen-image/` | pending |
| Qwen-Image-Edit | ModelScope or HF-Mirror | TBD | model files | `models/diffusion_models/qwen-image-edit/` | pending |
| Video model | ModelScope or HF-Mirror | TBD | model files | `models/diffusion_models/video/` | pending |

## Notes

- Gated models require official access tokens. Do not use unknown reuploads to bypass license gates.
- For the first smoke test, only one SDXL checkpoint is strictly required.
- ControlNet, IPAdapter, FLUX, Qwen, and video are added after ComfyUI can start and generate a base SDXL image.

