FROM runpod/worker-comfyui:5.8.5-base

# Nodig voor DWPose en de gebruikte KJNodes.
RUN comfy-node-install comfyui_controlnet_aux comfyui-kjnodes

# Nodig voor de GPU-uitvoering van DWPose.
# Geen "|| true": de build moet stoppen als dit mislukt.
RUN python -m pip install --no-cache-dir onnxruntime-gpu

# Vervang de standaard modelpad-configuratie door onze volledige configuratie.
COPY extra_model_paths.yaml /comfyui/extra_model_paths.yaml

# Laat de Docker-build direct controleren of alle vereiste paden aanwezig zijn.
RUN test -f /comfyui/extra_model_paths.yaml \
    && grep -q "diffusion_models: models/diffusion_models/" /comfyui/extra_model_paths.yaml \
    && grep -q "text_encoders: models/text_encoders/" /comfyui/extra_model_paths.yaml \
    && grep -q "clip_vision: models/clip_vision/" /comfyui/extra_model_paths.yaml \
    && grep -q "vae: models/vae/" /comfyui/extra_model_paths.yaml \
    && grep -q "loras: models/loras/" /comfyui/extra_model_paths.yaml

# Nieuwe herkenbare image-versie; zorgt ook voor een gewijzigde image digest.
LABEL org.opencontainers.image.version="wan-move-model-paths-v3"
