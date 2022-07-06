%%Team Aryans CVT Model 

%% System Constants

n = 100; % number of record points
VehicleWeight = 451.948; %Weigth in lb.
HillClimb = 20; %Degrees
RTire = 11.3; %Tire Radius (in.)
Rgb=1/7; %Gear Box Reduction Ratio

eHP = 7.5; %Engine power engagment (hp) %RuleBook
sHP = 8.5; %Engine power shift (hp)
dWe = 2800; %Desired engagement angular velocity of engine (RPM)
dWs = 3600; %Desired shift Angular Velocity of engine (RPM)

%BELT >> values to be updated!!

cc = 8.5; %Center to center (in.)
U = 0.13; %Coefficient of Friction
MBelt=0.01579/35.4331; %Mass per unit length (values to be updated)
BeltH=0.55; %Cross cl Height (in.)
BeltWTop=0.85; %Cross Sectional Width at top (in.)
BeltWBottomn=0.65; %Cross Sectional Width at Bottomn (in.)
Ks = 1; %Service factor
Kc = 0.965; %Belt parameter 
Kb = 576; %Belt parameter 
Nd = 1; %Design factor

%END BELT

%PRIMARY >>

%Sheaves
Theta = 23; %Belt groove primary (Degrees)
X1max = 0.8; %Total sheave displacement (in.)
Rpmin = 1.75+(BeltH/2); %Minimum pitch radius (in.)
Rpmax = 3-(BeltH/2); %Maximum pitch radius (in.)


%Pressure Spring
Kp=84.79; %Linar spring rates (lbf/in.)

Xp0 = 0.975; %Intalled pretenion (in.)

%Flyweights
Ufly=0.002; %Coefficient of friction between flyweight ramps and flyweight roller bearings


Deltastart=10; %Ramp angles (Degrees) [Set: B]
Deltaend=13;
FlatAngle=10; % !!
I0=.05; %Flat angle constant. Affects initial shift out point
Mfly=0.192*(3/14593.903);

Rfly0 = 1.875; %Initial radius (in.) (1.34)
RflyMax=2.345; %Full Shift Radius (in.) (1.815)
Mlink=21*(3/14593.903); %Link mass for four arms (Sluggs)

%SECONDARY >>
%Sheaves
Phi = 23; %Belt groove secondary (Degrees)
X2max = 0.8228; %Total sheave displacement (in.)
Rsmin = Rpmax*0.9; %Minimum pitch radius (in.)
Rsmax = Rpmin*3.9; %Maximum pitch radius (in.)

%Torsional Spring
Xt0 = 2.0196; %Intalled linar Length (in.)
Kt=25.23;

Yt0=89;

Ymax=40; %Total Secondary Twist (Degrees)
Lambda=0.595; %Torsional spring rates (in*lbf/Degree.)

%Helix
Etastart = 40; 
Etaend=48;

Rr = 1.455; %Ramp radius (in.)

%% Calculated Variables 

%Engine
%Design Hp

Hde = eHP*Ks*Nd; %Design power engagement (hp) 
Hds = sHP*Ks*Nd; %Design power during shift (hp)

%Vehicle Weight Torque Load
Tv=(VehicleWeight*sind(HillClimb)*RTire*Rgb)/12; %ft.*lbs

%Belt
BeltSH=((((BeltWTop-BeltWBottomn)/2)^2)+(BeltH^2))^(.5); %Side Face Height (in.)

%Flyweights
Rfly=linspace(Rfly0, RflyMax, n); %Flyweight ramp radius through shift (in.) [Vector]
Rlink=1.625+(0.625.*acos((Rr-1.625)./1.25));

%Flyweight Ramp Angles

% !!
Delta = linspace(Deltastart,Deltaend,n);

%Delta=FlatAngle.*ones(1,n);
%Delta(1,((I0*n)+1):n)=linspace(Deltastart,Deltaend,(n-(I0*n)));



%Sheaves
Rp = linspace(Rpmin, Rpmax, n); %Primary radius through shift (in.) [Vector]
Rs = linspace(Rsmax, Rsmin, n); %Secondary radius through shift (in.) [Vector]

%Shift Ratio
R=Rs./Rp;

%Shift Distances
X1 = linspace(0, X1max, n); %Primary sheave displacement through shift (in.) [Vector]
X2 = linspace(0, X2max, n); %Secondary sheave displacement through shfit (in.) [Vector]
Y2 = linspace(0, Ymax, n); %Secondary sheave twist through shift (Degrees) [Vector]

%Helix
Eta = linspace(Etastart, Etaend, n);




%Effective Coefficient of Friction
Uep = U/(sind((Theta)/2)); %Primary effective coefficient of friction
Ues = U/(sind((Phi)/2)); %Secondary effective coefficient of friciton

[TpE,TsE,Alpha,Beta,Tp1,Tp0E,Cpx,Fpx,Fps,Fflyx,Ffly,wpc,MPMax,Fxts,Fyts,FHelix,Fsx,Csx,Ts0,Ts1,MSMax,Effs] = Engagement(n,Hde,dWe,Tv,Rp,Rs,R,U,Uep,Ues,MBelt,Ufly,cc,Theta,Phi,Kp,Xp0,Delta,Mfly,Rfly,Mlink,Rlink,Xt0,Kt,Yt0,Lambda,Eta,Rr);

if wpc(1)>=2100 %&& wpc(1) <= 3100 
    [TpShift,TsShift,AlphaShift,BetaShift,Tp1Shift,Tp0Shift,CpxShift,FpxShift,FpsShift,FflyxShift,FflyShift,wpcShift,MPMaxShift,FxtsShift,FytsShift,FHelixShift,FsShift,FsxShift,CsxShift,Ts0Shift,Ts1Shift,MSMaxShift,EffsShift] = Shift(n,Hds,dWs,Tv,Rp,Rs,R,X1,X2,Y2,U,Uep,Ues,MBelt,BeltSH,Ufly,cc,Kc,Theta,Phi,Kp,Xp0,Delta,Mfly,Rfly,Mlink,Rlink,Xt0,Kt,Yt0,Lambda,Eta,Rr);
    V=(wpcShift.*Rgb.*60.*2.*pi.*RTire)./(R.*63360);
    
else
    fprintf("setup didn't meet optimal performance");
end

%Vehicle Speed


wpcLow=linspace(wpc(1),wpcShift(1),n);
VLow=(wpcLow.*Rgb.*60.*2.*pi.*RTire)./(R(1)*63360);
VShift=(wpcShift.*Rgb.*60.*2.*pi.*RTire)./(R.*63360);

wpcPLOT=[wpcLow wpcShift];
V=[VLow VShift];
Rplot=R(1).*ones(1,n);
Rplot=[Rplot R];


plotting1(V,n,dWe,R,Rplot,wpcPLOT,dWs,MPMaxShift,TpShift,Tp0Shift,Tp1Shift,FpxShift,MSMaxShift,TsShift,Ts0Shift,Ts1Shift,FsxShift);

save('vars.mat','V','n','dWe','R','wpc','dWs','MPMaxShift','TpShift','Tp0Shift','Tp1Shift','FpxShift','MSMaxShift','TsShift','Ts0Shift','Ts1Shift','FsxShift')

