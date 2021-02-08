clear all;close all;
N=10;
disp('Input message sequence')
n=randi([0,1],1,N)%input 

for i1=1:N
    if n(i1)==1;
        nn(i1)=1;
    else
        nn(i1)=-1;
    end
    
end
%signal
s=100;
i=1;
t=0:1/s:N;
for j=1:length(t)
    if t(j)<=i;
        m(j)=nn(i);
    else
        m(j)=nn(i);
        i=i+1;
    end
end

%plotting
subplot(411);
plot(t,m,'k-');
xlabel('Time');
ylabel('Amplitude');
title('NRZ Polar Signal');

%carier
c=cos(2*pi*2*t);
subplot(412);
plot(t,c,'k-');
xlabel('Time');
ylabel('Amplitude');
title('carrier signal');
% BPSK modulation
x=m.*c;
subplot(413);
plot(t,x,'k-');
xlabel('Time');
ylabel('Amplitude');
title('BASK Signal');
%coherent detection
y=x;
y1=y.*c;%product modulator
subplot(414);
plot(t,y1,'k-');

%integration o/p
%k=1/s:1/s:1;
int_op=[];
for ii=0:s:length(y1)-s;
    int_o=(1/s)*trapz(y1(ii+1:ii+s));
    int_op=[int_op int_o];
end
%hard-decision decoding
disp('Detected bits:')
det=(round(int_op,1)>=0.5)
%BER Computation
ber=sum(n~=det)/N

