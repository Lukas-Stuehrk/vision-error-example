# Vision error example

A minimal example to demonstrate a problem when running iOS' Vision framework on the simulator. It tries to process a
video frame by frame. When running on a real device, everything will work. When running on the simulator, it will fail
with the following error:

```
VNRecognizeTextRequest produced an internal error" UserInfo={NSLocalizedDescription=VNRecognizeTextRequest produced an internal error, NSUnderlyingError=0x7ffae8d0c3f0 {Error Domain=com.apple.vis Code=3 "Failed to transfer inBuffer to croppedBuffer. Error -12212" UserInfo={NSLocalizedDescription=Failed to transfer inBuffer to croppedBuffer. Error -12212}}}
```
