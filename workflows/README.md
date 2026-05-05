# Workflow 目录

这里保存可提交的 ComfyUI API-format workflow JSON。

预期文件名：

```text
sdxl_panel.json
sdxl_panel_euler_test.json
sdxl_panel_controlnet_canny_test.json
sdxl_panel_controlnet_depth_test.json
sdxl_panel_controlnet_openpose_test.json
sdxl_panel_ipadapter_test.json
sdxl_panel_controlnet.json
sdxl_inpaint.json
flux_keyframe.json
qwen_text_image.json
qwen_edit.json
qwen_image_lightning_test.json
qwen_image_edit_test.json
```

内容项目中的脚本会在提交给 ComfyUI 前，把 prompt、尺寸和 seed patch 到这些 workflow 中。

模型权重、缓存和生成输出不要放在这个目录。

## 已验证

- `sdxl_panel.json`：已通过 512x768 和 768x1152 测试。
- `sdxl_panel_euler_test.json`：已通过 1024x1536 连续两张测试，用于高分辨率候选。
- `sdxl_panel_controlnet_canny_test.json`：已通过 512x768 Canny ControlNet 测试。
- `sdxl_panel_controlnet_depth_test.json`：已通过 512x768 Depth ControlNet 测试。
- `sdxl_panel_controlnet_openpose_test.json`：已通过 512x768 OpenPose ControlNet 测试。
- `sdxl_panel_ipadapter_test.json`：已通过 512x768 IPAdapter 参考图测试。
- `qwen_image_lightning_test.json`：已通过 512x768 Qwen-Image Lightning 测试。
- `qwen_image_edit_test.json`：已通过参考图 + 中文编辑指令测试。

## 尺寸建议

- `768x1152`：常规默认尺寸。
- `1024x1536`：使用 `sdxl_panel_euler_test.json`，不要使用默认 `dpmpp_2m_sde + karras` 配置。
