tic
data = audioread('LGANTE.wav');
% N = 2^23; %Notar que N > L
X = fft(data);
toc
soundsc(data,16000)