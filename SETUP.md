# 部署说明

本仓库只保存本地生图工厂的管理层文件。

以下内容不会提交到 Git：

- ComfyUI 运行目录
- Python 虚拟环境
- 模型权重
- 生成输出
- 下载缓存
- 本地日志

## 安装 ComfyUI

```bash
/Users/markus/AI/image-factory/scripts/install_comfyui.sh
```

如果 GitHub clone 很慢，可以稍后重试。当前机器曾通过 GitHub zipball 方式完成源码安装。

## 启动

```bash
/Users/markus/AI/image-factory/scripts/start_comfyui_venv.sh
```

## 健康检查

```bash
/Users/markus/AI/image-factory/scripts/healthcheck.sh
```

预期返回 JSON，并能看到：

```text
device: mps
ram_total: 137438953472
```

## 下载模型

使用国内网络友好的下载策略：

```bash
export HF_ENDPOINT=https://hf-mirror.com
export HF_HUB_ENABLE_HF_TRANSFER=1
/Users/markus/AI/image-factory/scripts/download_first_batch.sh
```

模型状态记录在：

```text
docs/model-inventory.md
```

## 测试生成

在内容项目中调用：

```bash
python3 pipeline/scripts/generate_image_local.py \
  --workflow sdxl_panel \
  --prompt-file tmp/image-prompts/api_smoke_test.txt \
  --negative-prompt-file pipeline/negative_prompts/sdxl_comic.txt \
  --out /Users/markus/AI/image-factory/outputs/sdxl_smoke.png \
  --width 512 \
  --height 768 \
  --seed 12345
```

