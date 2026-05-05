# Download Strategy For China Mainland Networks

Large model downloads should use a source strategy instead of ad hoc browser downloads.

Priority:

```text
1. ModelScope official model page or mirrored model
2. Hugging Face through HF-Mirror
3. Hugging Face official endpoint
4. Direct URL with resumable curl
```

## Hugging Face Mirror

Use:

```bash
export HF_ENDPOINT=https://hf-mirror.com
export HF_HUB_ENABLE_HF_TRANSFER=1
```

Example:

```bash
/Users/markus/AI/image-factory/scripts/download_model.sh \
  --source hf-mirror \
  --repo owner/model \
  --filename model.safetensors \
  --local-dir /Users/markus/AI/image-factory/models/checkpoints
```

## ModelScope

Use ModelScope when the model exists there with the same license and expected files.

Install CLI:

```bash
python3 -m pip install -U modelscope
```

Example:

```bash
/Users/markus/AI/image-factory/scripts/download_model.sh \
  --source modelscope \
  --repo owner/model \
  --filename model.safetensors \
  --local-dir /Users/markus/AI/image-factory/models/checkpoints
```

## Direct URL

Use direct URL only for official release assets or trusted mirrors.

```bash
/Users/markus/AI/image-factory/scripts/download_model.sh \
  --source url \
  --url "https://example.com/model.safetensors" \
  --local-dir /Users/markus/AI/image-factory/models/checkpoints
```

## Rules

- Prefer `.safetensors` over `.ckpt` when available.
- Record every downloaded file in `docs/model-inventory.md`.
- Do not mix unofficial renamed files into production workflows without noting origin.
- Keep model weights outside the content project.
- For gated models, use the official source and token instead of unofficial reuploads.
- If a mirror is down, switch source but keep the same destination folder.

