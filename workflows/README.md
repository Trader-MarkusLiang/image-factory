# Workflow 目录

这里保存可提交的 ComfyUI API-format workflow JSON。

预期文件名：

```text
sdxl_panel.json
sdxl_panel_controlnet_canny_test.json
sdxl_panel_controlnet.json
sdxl_inpaint.json
flux_keyframe.json
qwen_text_image.json
qwen_edit.json
```

内容项目中的脚本会在提交给 ComfyUI 前，把 prompt、尺寸和 seed patch 到这些 workflow 中。

模型权重、缓存和生成输出不要放在这个目录。

## 已验证

- `sdxl_panel.json`：已通过 512x768 和 768x1152 测试。
- `sdxl_panel_controlnet_canny_test.json`：已通过 512x768 Canny ControlNet 测试。

## 待排障

- `1024x1536` 当前会生成纯黑图，暂不作为默认生产尺寸。
