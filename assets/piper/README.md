Place Piper model files here (Russian).

Required files (rename accordingly):
- voice.onnx
- voice.onnx.json

These are copied to app support directory on first use.

Android: include libpiper.so in android/app/src/main/jniLibs/arm64-v8a/
iOS: link libpiper.a or libpiper.dylib into Runner and ensure the symbol
`piper_generate_speech` is available (DynamicLibrary.process()).
