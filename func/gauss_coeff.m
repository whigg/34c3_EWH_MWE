function coeff=gauss_coeff(R,fr,n)% calculate Gauss Filtercoefficients for radius fr and max degree nb=log(2)/(1-cos(fr/(R/1000)));coeff=zeros(n+1,1);coeff(1)=1;coeff(2)=(1+exp(-2*b))/(1-exp(-2*b))-1/b;for hi=3:n+1  coeff(hi)=-((2*(hi-1)-1)/b)*coeff(hi-1)+coeff(hi-2);end