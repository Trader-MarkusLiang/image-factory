# 第一批模型清单

第一批是“部署和测试批次”。它有意小于最终愿望清单，目标是先让本地生产线跑通，再逐步补齐 IPAdapter、FLUX、Qwen 和视频模型。

## A 级：SDXL 主生产

| 任务 | 来源 | 仓库 | 文件 | 目标目录 | 状态 |
| --- | --- | --- | --- | --- | --- |
| SDXL base checkpoint | HF-Mirror | `stabilityai/stable-diffusion-xl-base-1.0` | `sd_xl_base_1.0.safetensors` | `ComfyUI/models/checkpoints/` | 已安装 |
| SDXL VAE | HF-Mirror | `madebyollin/sdxl-vae-fp16-fix` | `diffusion_pytorch_model.safetensors` | `ComfyUI/models/vae/` | 已安装 |
| 漫画/动画风格 SDXL checkpoint | HF-Mirror | `cagliostrolab/animagine-xl-4.0` | `animagine-xl-4.0.safetensors` 或可用 safetensors | `ComfyUI/models/checkpoints/` | 待下载 |

## B 级：控制和参考

| 任务 | 来源 | 仓库 | 文件 | 目标目录 | 状态 |
| --- | --- | --- | --- | --- | --- |
| SDXL Canny ControlNet | HF-Mirror | `xinsir/controlnet-canny-sdxl-1.0` | safetensors | `ComfyUI/models/controlnet/` | 已安装 |
| SDXL OpenPose ControlNet | HF-Mirror | `xinsir/controlnet-openpose-sdxl-1.0` | safetensors | `ComfyUI/models/controlnet/` | 已安装 |
| SDXL Depth ControlNet | HF-Mirror | `xinsir/controlnet-depth-sdxl-1.0` | safetensors | `ComfyUI/models/controlnet/` | 已安装 |
| IPAdapter SDXL | HF-Mirror | `h94/IP-Adapter` | `sdxl_models/ip-adapter-plus_sdxl_vit-h.safetensors` | `ComfyUI/models/ipadapter/` | 部分下载，待补 |
| IPAdapter CLIP Vision | HF-Mirror | `h94/IP-Adapter` | `sdxl_models/image_encoder/model.safetensors` | `ComfyUI/models/clip_vision/` | 待下载 |

## C 级：修复和放大

| 任务 | 来源 | 仓库 | 文件 | 目标目录 | 状态 |
| --- | --- | --- | --- | --- | --- |
| 放大模型 | HF-Mirror 或可信直链 | 待定 | `.pth` / `.safetensors` | `ComfyUI/models/upscale_models/` | 待下载 |
| SDXL inpaint | HF-Mirror | 待定 | safetensors | `ComfyUI/models/checkpoints/` | 待下载 |

## D 级：关键帧、中文和视频实验

| 任务 | 来源 | 仓库 | 文件 | 目标目录 | 状态 |
| --- | --- | --- | --- | --- | --- |
| FLUX Schnell | HF-Mirror | `black-forest-labs/FLUX.1-schnell` | diffusers safetensors | `ComfyUI/models/diffusion_models/flux1-schnell/` | 待下载 |
| Qwen-Image | ModelScope 或 HF-Mirror | 待定 | model files | `ComfyUI/models/diffusion_models/qwen-image/` | 待下载 |
| Qwen-Image-Edit | ModelScope 或 HF-Mirror | 待定 | model files | `ComfyUI/models/diffusion_models/qwen-image-edit/` | 待下载 |
| 视频模型 | ModelScope 或 HF-Mirror | 待定 | model files | `ComfyUI/models/diffusion_models/video/` | 实验项 |

## 备注

- gated 模型需要官方 token，不使用来源不明的搬运版本绕过授权。
- 第一轮 smoke test 只需要一个 SDXL checkpoint。
- ControlNet、IPAdapter、FLUX、Qwen 和视频模型应在 ComfyUI 基线生成稳定后逐步加入。

