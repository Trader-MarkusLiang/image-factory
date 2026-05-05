# 国内网络模型下载策略

大模型下载必须使用固定策略，不要每次临时从浏览器手动下载。

推荐优先级：

```text
1. ModelScope 官方模型页或可信镜像
2. Hugging Face + HF-Mirror
3. Hugging Face 官方源
4. 可信直链 + 断点续传
```

## HF-Mirror

环境变量：

```bash
export HF_ENDPOINT=https://hf-mirror.com
export HF_HUB_ENABLE_HF_TRANSFER=1
export HF_HUB_OFFLINE=0
```

示例：

```bash
/Users/markus/AI/image-factory/scripts/download_model.sh \
  --source hf-mirror \
  --repo owner/model \
  --filename model.safetensors \
  --local-dir /Users/markus/AI/image-factory/ComfyUI/models/checkpoints
```

## ModelScope

当同一模型在 ModelScope 上有官方发布或可信同步版本时，优先使用 ModelScope。

安装 CLI：

```bash
python3 -m pip install -U modelscope
```

示例：

```bash
/Users/markus/AI/image-factory/scripts/download_model.sh \
  --source modelscope \
  --repo owner/model \
  --filename model.safetensors \
  --local-dir /Users/markus/AI/image-factory/ComfyUI/models/checkpoints
```

## 可信直链

只在官方 release、官方 CDN 或可信镜像提供文件时使用。

```bash
/Users/markus/AI/image-factory/scripts/download_model.sh \
  --source url \
  --url "https://example.com/model.safetensors" \
  --local-dir /Users/markus/AI/image-factory/ComfyUI/models/checkpoints
```

## 规则

- 优先使用 `.safetensors`，避免来源不清的 `.ckpt`。
- 每次下载后更新 `docs/model-inventory.md`。
- 不把模型权重复制到漫画内容项目。
- 不把模型权重提交到 Git。
- gated 模型必须使用官方授权来源和 token。
- 镜像不可用时可以切换来源，但目标目录保持一致。

