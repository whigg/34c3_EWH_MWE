function erg=waterheight(C,S,GC,P,n,lambda,theta,rho_E,rho_w,R)% Calculation of equivalent water heightpersistent kn% Love Numbersif isempty(kn)  kn=load('loadLove.txt');enderg=0;for L=2:n % Degree  indL=L+1;  fak1=(2*L+1)/(1+kn(indL));  sum1=0;  for M=0:L % order    indM=M+1;    sum1=sum1+...        ( GC(indL)*C(indL,indM)*cos(M*lambda) + GC(indL)*S(indL,indM)*sin(M*lambda) )*P(indL,indM);  end  erg=erg+fak1*sum1;enderg=R*rho_E/(3*rho_w)*erg;  end