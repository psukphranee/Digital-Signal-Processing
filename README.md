# Digital-Signal-Processing
Capstone project of decoding DTMF tones is in the Lab 8 directory.

1. Clone Repo
2. Open MATLAB
4. Navigate to Lab 8's directory
5. `add path .` to add the directory to MATLAB's search path
6. Type the following lines in the MATLAB's command line
```
[x, fs] = audioread('phonetones.wav'); %loads wav file
output = dtmfdecode(x,fs); 
```

