function hd=ideal_hp(Wc,N) 
 
%compute the ideal highpass fiter unit pulse respondence hd(n) 
 
%wc: cutoff frequency 
 
%N: window length 
 
%hd: unit pulse respondence 
 
alpha=(N-1)/2; 
 
n=0:1:N-1; 
 
m=n-alpha+eps; 
 
hd=[sin(pi*m)-sin(Wc*m)]./(pi*m); 