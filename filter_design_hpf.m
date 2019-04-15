clear all;clc;
[jet_engine,fs] = audioread('jet_engine.wav');
[audio_voice,fs] = audioread('audio_voice.mp3');
jet_engine((length(audio_voice)+1):end) = [];
audio_voice((length(audio_voice)+1):end) = [];

%sound(audio_voice,fs);
figure;
freqz(audio_voice);
title('audio voice');
%sound(jet_engine,fs);
figure;
freqz(jet_engine);
title('jet engine');

audio_input = audio_voice + jet_engine;
% Audio audio_input sebelum difilter
sound(audio_input,fs);

%========= Jalanin dulu sampai sini ======%

wp = 2*pi*2000/fs; ws = 2*pi*2200/fs;
tr_width = abs(ws - wp);
wc = abs((ws+wp)/2);
M = ceil(6.6*pi/tr_width) + 1;
hd = ideal_lp(wc,M);
w_ham = (hamming(M));
h = hd.*transpose(w_ham);

a_filter=[1];

audio_filtered = filter(h,a_filter,audio_input);
% audio_filtered
sound(audio_filtered,fs);

figure;
freqz(audio_input);
title('audio input');
figure;
freqz(audio_filtered);
title('audio filtered');