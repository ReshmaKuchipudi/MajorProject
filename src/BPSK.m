%BER of BPSK modulation under AWGN channel
%Generate Random input bits
N=10000000;%data size
x=randi([0 1],1,N);% random input bits
%BPSK Mapping
%bit 1-->1 and bit 0-->-1
for i=1:N
    if x(i)==0
        m(i)=-1;
    else
        m(i)=1;  
    end
end
%plot(m);
%AWGN Channel
%n=mean+sd.*randn(1,10000)
ber_sim=[];
ber_the=[];
for EbN0dB=0:2:10
    SNR=10^(EbN0dB/10);
    n=sqrt(1/(2*SNR))*randn(1,N); %AWGN
    r=m+n;
    for i=1:N
        if r(i)>0
            m_cap(i)=1;
        else
            m_cap(i)=0;
        end
    end
    ber1=sum((x~=m_cap))/N;
    ber_sim=[ber_sim ber1];
    ber_the=[ber_the 0.5*erfc(sqrt(SNR))];
end
EbN0dB=0:2:10;
%graph drawn between Eb/N0dB and BER w.rt to simulation represents in Red color and with respect to theory in green color 
semilogy(EbN0dB,ber_sim,'ro-',EbN0dB,ber_the,'g+-');
xlabel("Eb/N0dB");
ylabel("BER");
legend("Simulation","Theory");
