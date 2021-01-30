clear all;
clc;
rng('shuffle');
SNRdB=[1:0.5:13];% signal to noise ratio
blocklength=1000000;
bits=randi([0,1],[1,blocklength]);% no of bits
BER=zeros(size(SNRdB));% bit error rate
chNoise=(randn(1,blocklength)+1i*randn(1,blocklength));%noise
for k=1:length(SNRdB)
    SNR=10^(SNRdB(k)/10);
    Txbits=sqrt(SNR)*(2*bits-1);%transmission bits
    Rxbits=Txbits+chNoise;%received bits
    Decodebits=((real(Rxbits))>=0);%extracting real part 
    BER(k)=sum(Decodebits~=bits)/blocklength;%bit error rate
    
    
end

semilogy(SNRdB,BER,'bs','LineWidth',2.0);%graph drawn b/w signal to noise ratio and bit error rate
hold on;%to draw another line in the same graph
semilogy(SNRdB,0.5*erfc(sqrt(10.^(SNRdB/10))/sqrt(2)),'r-.','LineWidth',2.0);%graph drwan b/w signal to noise ratio and erfc
axis on;
grid on;
legend('AWGN','Theory')
xlabel('SNR(dB)');
ylabel('BER');
title('BER vs SNR(dB)');


