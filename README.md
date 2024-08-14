# Digital-Signal-Processing
Capstone project of decoding DTMF tones is in the lab 8 directory.

1. Clone Repo
2. Open MATLAB
3. Add the project folder to MATLAB's path
4. Navigate to lab 8's directory
5. Type the following lines in the MATLAB's command line

```
[x, fs] = audioread('phonetone.wav');
output = dtmfdecode(x,fs);
```

