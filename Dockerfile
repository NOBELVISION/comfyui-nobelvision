FROM runpod/worker-comfyui:5.8.5-base

RUN comfy-node-install comfyui_controlnet_aux comfyui-kjnodes

RUN pip install onnxruntime-gpu || true
