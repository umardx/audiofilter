clear all;clc;
[audio_voice,fs] = audioread('audio_voice.wav');

f1 = 3500;
f2 = 3600;
f3 = 4000;
n = 0:1/fs:10;
x1 = cos(2*pi*f1*n);
x2 = cos(2*pi*f2*n);
x3 = cos(2*pi*f3*n);
x = x1 + x2 + x3; clear x1, clear x2; clear x3;
x(end) = [];

audio_voice((length(x)+1):end) = [];
sound(audio_voice,fs);

audio_input_temp = x + audio_voice;
audio_input_temp = audio_input_temp/max(abs(audio_input_temp));
audiowrite('audio_input.wav', audio_input_temp, fs);
[audio_input,fs] = audioread('audio_input.wav');
audio_input = transpose(audio_input);
sound(audio_input, fs);

wp = 2*pi*3400/fs; ws = 2*pi*3500/fs;
tr_width = abs(ws - wp);
wc = abs((ws+wp)/2);
M = ceil(6.6*pi/tr_width) + 1;
hd = ideal_lp(wc,M);
w_ham = (hamming(M));
h = hd.*transpose(w_ham);

a_filter=[1];

fileID = fopen('koef_h.txt','w');
fprintf(fileID,'%d,',h);
fclose(fileID);

audio_filtered = filter(h,a_filter,audio_input);
sound(audio_filtered,fs);
figure;
freqz(audio_input);
title('audio input');
figure;
freqz(audio_filtered);
title('audio filtered');
