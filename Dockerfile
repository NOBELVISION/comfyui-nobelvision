# Eigen ComfyUI-worker voor NOBELVISION.
# Basis is het officiele Runpod-image; daar komen alleen de nodes bij
# die jouw workflow nodig heeft.

FROM runpod/worker-comfyui:5.8.5-base

# comfyui_controlnet_aux levert DWPreprocessor en PixelPerfectResolution.
# ComfyUI-KJNodes staat erbij omdat je die op je pod ook hebt draaien.
RUN comfy-node-install comfyui_controlnet_aux comfyui-kjnodes

# DWPose draait op onnxruntime. Zit niet standaard in het basisimage.
RUN uv pip install --system onnxruntime-gpu || pip install onnxruntime-gpu
