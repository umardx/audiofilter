clear;clc;
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
audio_filtered = audio_filtered/max(abs(audio_filtered));
sound(audio_filtered,fs);
audiowrite('audio_filtered.wav', audio_filtered, fs);
figure;
freqz(audio_input);
title('audio input');
figure;
freqz(audio_filtered);
title('audio filtered');