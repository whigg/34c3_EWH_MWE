%% Minimum Working example% calculating the Equivalent Water Height (EWH) due to gravity change between % two GRACE monthly solutions. This example calculates the EWH from gravity% change between May 2002 and May 2017 from:% Mayer-Gürr, Torsten; Behzadpour, Saniya; Ellmer, Matthias; Kvas, Andreas; % Klinger, Beate; Zehentner, Norbert (2016): ITSG-Grace2016 - Monthly and Daily % Gravity Field Solutions from GRACE. GFZ Data Services. % http://doi.org/10.5880/icgem.2016.007clear alladdpath data func%% Spherical harmonic coefficients% Files can be downloaded from http://ifg.tugraz.at/ITSG-Grace2016% this example uses unconstrained monthly solutions of degree 120file1='ITSG-Grace2016_n120_2002-05.gfc';file2='ITSG-Grace2016_n120_2017-05.gfc';%% Grid in degree for Greenland% stepdelta_winkel=1;% latitude limitslatlim=[58 85];la=latlim(1):delta_winkel:latlim(2);% thete: co-latitudetheta=90-la;% longitude limitslonlim=[-75 -12];lo=lonlim(1):delta_winkel:lonlim(2);% grid[x,y]=meshgrid(theta,lo);%% Radius Gaussian Filter for coefficientsgau=500; % in kilometers%% Read coefficients from datafilesfid=fopen(file1);[C1, S1, GM, R, n]=read_coeff(fid);fclose(fid);fid=fopen(file2);[C2, S2, GM, R, n]=read_coeff(fid);fclose(fid);%% Delta of coefficients for calculationsdC=C2-C1;dS=S2-S1;%% Gaussian FilterGC=gauss_coeff(R,gau,n);%% Equivalent Water Heightrho_E=5540; % average density of Earth in kg/m^3rho_w=1000; % density of water in kg/m^3EWH=zeros(size(x));for h1=1:size(x,2) % co-latitude in column of x  P=norm_egendre_functions(x(1,h1)*pi/180,n); % only depends on theta  for h2=1:size(x,1)    EWH(h2,h1)=equiv_water_height(dC,dS,GC,P,n,y(h2,h1)*pi/180,x(h2,h1)*pi/180, rho_E,rho_w,R);  end%  fprintf(' %d \n',h1);end%% Plotmesh(lo,la,EWH');cb=colorbar;xlabel('Longitude');ylabel('Latitude');set(get(cb,'ylabel'),'string','EWH [m]');