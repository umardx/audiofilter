clear all;clc;
[audio_voice,fs] = audioread('audio_voice.mp3');

f1 = 50;
f2 = 100;
f3 = 150;
n = 0:1/fs:10;
x1 = cos(2*pi*f1*n);
x2 = cos(2*pi*f2*n);
x3 = cos(2*pi*f3*n);
x = x1 + x2 + x3; clear x1, clear x2; clear x3;
x(end) = [];

audio_voice((length(x)+1):end) = [];
%sound(audio_voice,fs);

audio_input_temp = x + audio_voice;
audio_input_temp = audio_input_temp/max(abs(audio_input_temp));
audiowrite('audio_input.wav', audio_input_temp, fs);
[audio_input,fs] = audioread('audio_input.wav');
audio_input = transpose(audio_input);
%sound(audio_combine, fs);

wp = 2*pi*300/fs; ws = 2*pi*150/fs;
tr_width = abs(ws - wp);
wc = abs((ws+wp)/2);
M = ceil(6.6*pi/tr_width) + 1;
hd = ideal_hp(wc,M);
w_ham = (hamming(M));
h = hd.*transpose(w_ham);

a_filter=[1];

audio_filtered = filter(h,a_filter,audio_input);
sound(audio_filtered,fs);
figure;
title('audio_input');
freqz(audio_input);
figure;
title('audio_filtered');
freqz(audio_filtered);