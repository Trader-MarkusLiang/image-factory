# 分阶段推进路线

本地生图工厂按阶段推进。每个阶段只在“可重复运行、结果已记录、不会把模型权重提交到 Git”之后提交并推送。

## 阶段 1：SDXL + ComfyUI API 基线

状态：已完成。

目标：

- ComfyUI 在 Apple Silicon MPS 上启动。
- SDXL base checkpoint 能通过 API 生成图像。
- 内容项目脚本能调用本地 ComfyUI。
- 建立模型下载和部署文档。

已验证：

- `512x768` SDXL base：通过。
- `768x1152` SDXL base：通过。
- `512x768` SDXL + Canny ControlNet：通过。
- `1024x1536` SDXL base：未通过，输出纯黑图。

当前建议：

- 默认生产尺寸先使用 `768x1152`。
- `1024x1536` 进入排障队列，不作为第一批默认尺寸。

对应提交：

```text
90d26ad Initial image factory setup
e777cca Translate factory docs to Chinese
b1dbb27 Record deployment test results
```

## 阶段 2：角色参考图锁定

状态：已完成。

目标：

- 补齐 IPAdapter SDXL。
- 补齐 CLIP Vision image encoder。
- 建立最小 IPAdapter workflow。
- 用一张角色参考图验证参考锁定链路。

验收标准：

- IPAdapter 模型文件完整。已完成。
- CLIP Vision 模型文件完整。已完成。
- 最小 reference workflow 能通过 API 运行。已完成。
- 输出不是黑图，且能记录参考图输入路径。已完成。

风险：

- `h94/IP-Adapter` 通过 HF-Mirror 下载速度慢。
- 如果 HF-Mirror 卡住，改用 ModelScope 或可信直链。

实际记录：

- `ip-adapter-plus_sdxl_vit-h.safetensors` 已下载。
- `models/image_encoder/model.safetensors` 已下载，用于匹配 ViT-H。
- `sdxl_models/image_encoder/model.safetensors` 也已下载，但它是 bigG，不适配本次 plus vit-h 测试。
- 最小 workflow：`workflows/sdxl_panel_ipadapter_test.json`。
- 测试输出：`/Users/markus/AI/image-factory/outputs/sdxl_ipadapter_test.png`。

## 阶段 3：分镜控制扩展

状态：已完成。

目标：

- Canny workflow 从测试版升级为正式 `sdxl_panel_controlnet.json`。
- 增加 OpenPose workflow。
- 增加 Depth workflow。
- 记录三类 ControlNet 的适用场景。

验收标准：

- Canny：构图线稿输入可用。已完成。
- OpenPose：姿态控制输入可用。已完成。
- Depth：空间层次输入可用。已完成。
- 三类 workflow 都能通过 API 跑出非黑图。已完成。

实际记录：

- Canny workflow：`workflows/sdxl_panel_controlnet_canny_test.json`。
- Depth workflow：`workflows/sdxl_panel_controlnet_depth_test.json`。
- OpenPose workflow：`workflows/sdxl_panel_controlnet_openpose_test.json`。
- Canny 输出：`/Users/markus/AI/image-factory/outputs/sdxl_controlnet_canny_test.png`。
- Depth 输出：`/Users/markus/AI/image-factory/outputs/sdxl_controlnet_depth_test.png`。
- OpenPose 输出：`/Users/markus/AI/image-factory/outputs/sdxl_controlnet_openpose_test.png`。

## 阶段 4：1024x1536 黑图排障

状态：已完成。

目标：

- 找出 `1024x1536` 输出纯黑图原因。
- 测试不同采样器、步数、VAE、attention 参数和启动参数。
- 确定是否能把 1024x1536 作为默认生产尺寸。

验收标准：

- 如果修复：`1024x1536` 连续生成 2 张有效图。已完成。
- 如果不能修复：保留 `768x1152 -> upscale` 作为正式策略。不需要作为唯一策略。

实际记录：

- 默认 `dpmpp_2m_sde + karras` 在 `1024x1536` 下出现纯黑图。
- `euler + simple + 18 steps + cfg 5.5` 在 `1024x1536` 下连续两张有效。
- 高分辨率 workflow：`workflows/sdxl_panel_euler_test.json`。
- 默认建议：常规候选仍用 `768x1152`；高分辨率候选用 euler workflow。

## 阶段 5：关键帧和中文模型

状态：进行中。

目标：

- 接入 FLUX Schnell 或更适合 Apple Silicon 的 FLUX 变体。
- 接入 Qwen-Image。
- 评估 Qwen-Image-Edit。
- 明确 FLUX/Qwen 在漫画流程中的职责。

验收标准：

- 至少一个 FLUX workflow 能运行。
- 至少一个 Qwen-Image workflow 能运行。
- 记录模型体积、下载来源、运行速度和适合任务。

## 阶段 6：视频模型实验

状态：实验项。

目标：

- 只做轻量 smoke test，不进入正式漫画生产。
- 优先评估 ComfyUI 已支持的 Wan/LTX 类 workflow。

验收标准：

- 能生成极短视频片段。
- 记录内存占用、耗时和失败点。

## 阶段 7：漫画项目批量生成闭环

状态：待做。

目标：

- 内容项目通过 `run_episode_images.py` 调用本地工厂。
- 从 `image-jobs.json` 批量生成候选图。
- 生成结果进入 `episodes/epXX/images/candidates/`。
- `image-index.md` 记录后端、workflow、seed 和候选文件。

验收标准：

- EP01 或 EP02 至少一页能通过本地后端生成 2 张候选。
- 不覆盖 final。
- 不删除候选。
- 失败 job 可重试。

## 推送规则

- 阶段文档更新：单独提交。
- 每完成一个可验证阶段：单独提交。
- 模型权重、ComfyUI、venv、输出图不提交。
- 只提交脚本、文档、workflow、清单。
