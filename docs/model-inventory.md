# 模型清单

本文件记录本地漫画生产线实际使用的模型文件。

不要把模型权重复制到漫画内容项目，也不要提交到 Git。

## SDXL 主生产

| 角色 | 文件 | 状态 | 备注 |
| --- | --- | --- | --- |
| SDXL checkpoint | `ComfyUI/models/checkpoints/sd_xl_base_1.0.safetensors` | 已安装 | 主 panel 生成；已通过 MPS smoke test |
| SDXL VAE | `ComfyUI/models/vae/sdxl_vae_fp16_fix.safetensors` | 已安装 | 同目录保留原文件名 `diffusion_pytorch_model.safetensors` |
| SDXL inpaint | `ComfyUI/models/checkpoints/` | 待下载 | 局部修复 workflow 使用 |

## ControlNet

| 角色 | 文件 | 状态 | 备注 |
| --- | --- | --- | --- |
| OpenPose | `ComfyUI/models/controlnet/xinsir-controlnet-openpose-sdxl-1.0/` | 已安装 | 姿态控制；包含 base 和 twins safetensors |
| Canny / Lineart | `ComfyUI/models/controlnet/xinsir-controlnet-canny-sdxl-1.0/` | 已安装 | 构图轮廓控制；包含 base 和 V2 safetensors |
| Depth | `ComfyUI/models/controlnet/xinsir-controlnet-depth-sdxl-1.0/` | 已安装 | 场景深度控制 |

## 参考图和角色一致性

| 角色 | 文件 | 状态 | 备注 |
| --- | --- | --- | --- |
| IPAdapter | `ComfyUI/models/ipadapter/` | 部分下载 | HF-Mirror 下载很慢，已中断，后续换源补齐 |
| 林砚 LoRA | `ComfyUI/models/loras/` | 待训练 | 角色锁定 |

## 关键帧和中文图像

| 角色 | 文件 | 状态 | 备注 |
| --- | --- | --- | --- |
| FLUX | `ComfyUI/models/diffusion_models/` | 待下载 | 开篇图、封面、关键帧 |
| Qwen-Image | `ComfyUI/models/diffusion_models/` | 待下载 | 中文元素较多的图像 |
| Qwen-Image-Edit | `ComfyUI/models/diffusion_models/` | 待下载 | 语义编辑和局部修图 |

## 视频实验

| 角色 | 文件 | 状态 | 备注 |
| --- | --- | --- | --- |
| Wan / Hunyuan / LTX | 待定 | 实验项 | 不进入第一阶段正式生产 |

## 冒烟测试

| 日期 | 测试 | 结果 | 输出 |
| --- | --- | --- | --- |
| 2026-05-05 | SDXL base 通过 ComfyUI MPS API 生成 512x768 图像 | 通过 | `/Users/markus/AI/image-factory/outputs/sdxl_smoke.png` |
| 2026-05-05 | SDXL base 生成 768x1152 竖图 | 通过 | `/Users/markus/AI/image-factory/outputs/sdxl_768x1152_test.png` |
| 2026-05-05 | SDXL base 生成 1024x1536 竖图 | 未通过 | 输出为纯黑图，暂不作为默认生产尺寸 |
| 2026-05-05 | SDXL + Canny ControlNet 生成 512x768 控制图测试 | 通过 | `/Users/markus/AI/image-factory/outputs/sdxl_controlnet_canny_test.png` |

## 当前生产建议

- 默认本地生产尺寸先使用 `768x1152`。
- `1024x1536` 在当前 MPS/ComfyUI 组合下会生成纯黑图，后续需要单独排障。
- ControlNet Canny 的最小工作流已通过，可以继续扩展 OpenPose、Depth 和正式 panel workflow。
- IPAdapter 尚未完成下载，角色参考图锁定暂时先依赖 prompt、seed、LoRA 计划和 ControlNet。

## 下载来源策略

优先级：

```text
ModelScope
-> HF-Mirror，使用 HF_ENDPOINT=https://hf-mirror.com
-> Hugging Face 官方源
-> 可信直链
```

统一下载脚本：

```bash
/Users/markus/AI/image-factory/scripts/download_model.sh
```

每次下载后记录实际 repo id、文件名、来源、授权和日期。
