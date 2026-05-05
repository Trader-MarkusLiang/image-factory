# 本地生图工厂

这是漫画生产用的本地图像/视频生成工厂目录。

本目录有意和漫画内容项目分离。这里保存本地运行环境、模型下载脚本、ComfyUI workflow、下载清单和部署文档；模型权重、缓存、生成结果和 Python 虚拟环境不进入 Git。

主内容项目：

```text
/Users/markus/Documents/New project/
```

推荐服务地址：

```text
http://127.0.0.1:8188
```

## 目录结构

```text
ComfyUI/      # 本地 ComfyUI 运行目录，不提交
models/       # 预留模型目录，不提交
workflows/    # 可提交的 API-format workflow 模板
inputs/       # 控制图、参考图、mask 等输入，不提交
outputs/      # 测试和生成输出，不提交
cache/        # 下载和运行缓存，不提交
logs/         # 本地日志，不提交
scripts/      # 安装、启动、下载和健康检查脚本
docs/         # 下载策略、模型清单和部署记录
```

## 当前状态

- ComfyUI 已安装到 `ComfyUI/`。
- ComfyUI 已在 Apple Silicon MPS 上启动并通过健康检查。
- SDXL base + VAE 已部署。
- SDXL Canny / OpenPose / Depth ControlNet 已下载。
- SDXL 512x768 smoke test 已通过。
- IPAdapter、FLUX、Qwen、视频模型仍在第二批。

## 安装 ComfyUI

```bash
/Users/markus/AI/image-factory/scripts/install_comfyui.sh
```

如果 GitHub clone 很慢，可以稍后重试，或手动下载 ComfyUI zipball 后放入 `ComfyUI/`。

## 启动服务

```bash
/Users/markus/AI/image-factory/scripts/start_comfyui_venv.sh
```

健康检查：

```bash
/Users/markus/AI/image-factory/scripts/healthcheck.sh
```

## 下载模型

国内网络优先使用 ModelScope 或 HF-Mirror：

```bash
export HF_ENDPOINT=https://hf-mirror.com
export HF_HUB_ENABLE_HF_TRANSFER=1
/Users/markus/AI/image-factory/scripts/download_first_batch.sh
```

单模型下载：

```bash
/Users/markus/AI/image-factory/scripts/download_model.sh \
  --source hf-mirror \
  --repo owner/model \
  --filename model.safetensors \
  --local-dir /Users/markus/AI/image-factory/ComfyUI/models/checkpoints
```

相关文档：

```text
docs/download-strategy.md
docs/model-inventory.md
docs/first-batch-models.md
```

