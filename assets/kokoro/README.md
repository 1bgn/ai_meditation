Place Kokoro model files here.

Required files:
- kokoro-v1.0.onnx
- voices.json

Download:
- https://github.com/thewh1teagle/kokoro-onnx/releases/download/model-files-v1.0/kokoro-v1.0.onnx
- https://github.com/thewh1teagle/kokoro-onnx/releases/download/model-files-v1.0/voices-v1.0.bin

Convert voices-v1.0.bin to voices.json:
1) Install numpy
2) Run:
   python - <<'PY'
   import numpy as np, json
   data = np.load("voices-v1.0.bin")
   all_voices = {k: v.tolist() for k, v in data.items()}
   with open("voices.json", "w") as f:
       json.dump(all_voices, f)
   PY
