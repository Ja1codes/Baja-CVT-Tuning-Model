function [TpE,TsE,Alpha,Beta,Tp1,Tp0,Cpx,Fpx,Fps,Fflyx,Ffly,wpc,MPMax,Fxts,Fyts,FHelix,Fsx,Csx,Ts0,Ts1,MSMax,Effs] = Engagement(n,Hde,dWe,Tv,Rp,Rs,R,U,Uep,Ues,MBelt,Ufly,cc,Theta,Phi,Kp,Xp0,Delta,Mfly,Rfly,Mlink,Rlink,Xt0,Kt,Yt0,Lambda,Eta,Rr)

%Calculate Setup For Optimal Ement Point
%% Engagement Condition
%Design Power
Hd = Hde; %Design power at Ement (hp)
%Sheaves
Rp=Rp(1); %Primary radius during Ement
Rs=Rs(1); %Secondary radius during Ement
%Angular Velocity
Wp = dWe; %Primary angular velocity (RPM) *Assuming minimal speed differential*
Ws=Wp./Rs; %Secondary angular velocity (RPM)
%Flyweights
Rfly=Rfly(1);
Rlink=Rlink(1);
%Torque at Desired RPM
Tp=(Hd.*5252)./Wp; %Primary Torque (ft.*lbs)
Ts=Tp.*R(1); %Torque at secondary through shift (ft.*lbs)

%% Belt Calculations
Alpha = (pi-(2*asin((Rs-Rp)/cc)));
Beta= (pi+(2*asin((Rs-Rp)/cc)));

%% Secondary >>

%Torsional Spring
%Linear Rate
Fxts = Kt.*(Xt0); %Linear spring force (lbf)

%Torsional Rate
Fyts = (Lambda.*(Yt0)); %Torsional spring force (lbf*in)

%Torque Feedback
FHelix=((Ts.*12)+Fyts)./(2*Rr.*tand(Eta));

%Sheave Force
Fs=(FHelix+Fxts)./Beta; %Distributed Clamping Force

Fsx=(2.*Fs.*sin(Beta./2)).*2*tand(Phi/2); %Total force due to clamping
%Centrifugal Force

Ws=Ws.*(pi/30); %Converting to Radians Per Second
Cs=(1/12).*MBelt.*(Rs.^2).*(Ws.^2); %Distributed Centrifugal Force
Csx=2.*Cs.*sin(Beta./2); %Total Centrifugal force
%Belt Slack Tenion
Ts0x=(Fsx+Csx)./(1+exp(Ues.*Beta));
if Beta<=pi
Ts0=Ts0x./cos(.5*(pi-Beta));
elseif Beta>pi
Ts0=Ts0x./cos(.5*(Beta-pi));
end
%Taught Side Tenion
Ts1=Ts0.*exp(Ues.*Beta);

%Adjusting For Torque Load from Vehicle Weight
Ts0=Ts0-(Tv.*6)./Rs;
Ts1=Ts1+(Tv.*6)./Rs;
%Maximum Torque Tranferable (Without Slip)
MSMax=(Ts1-Ts0).*(Rs./12); %Maximum torque through shift without slipping (Ft.*lbs)
%Secondary Efficiency
Effs=(Ts./MSMax).*100; %Secondary Efficiency into gear box
%% Primary
%Taught side tenion
Tp1=Ts1;
%Slack side tenion
Tp0=Tp1./exp(Uep.*Alpha);
%Accounting for Motor Torque
Tp1=Tp1+((Tp.*6)./Rp);
Tp0=Tp0-((Tp.*6)./Rp);


%{
%Tension Component in X Direction
if Alpha<=pi
Tp0x=Tp0.*cos(.5*(pi-Alpha));
elseif Alpha>pi
Tp0x=Tp0.*cos(.5*(Alpha-pi));
end
if Alpha<=pi
Tp1x=Tp1.*cos(.5*(pi-Alpha));
elseif Alpha>pi
Tp1x=Tp1.*cos(.5*(Alpha-pi));
end

%}

%Centrifugal Force
Wp=Wp*(pi/30);
Cp=(1/12).*MBelt.*(Rp.^2).*(Wp.^2); %Distributed Centrifugal Force
Cpx=2.*Cp.*sin(Alpha./2); %Total Centrifugal Force
%Required side force
Fpx=(-Cpx); %Total clamping force
Fp=(Fpx./(2.*sin(Alpha./2)))./(2.*tand(Theta/2)); %Distributed clamping force
%Pressure Spring
Fps=Kp.*(Xp0); %Pressure spring force vector (lbf)
%Required Flyweight force
Fflyx=Fp+Fps;
Ffly=(Fflyx./tand(Delta))-(Fflyx./tan(acos((Rfly-1.625)./1.25)));
%Required engine speed
wpc=(12.*Ffly./((Mfly.*Rfly)+(Mlink.*Rlink))).^.5;
wpc=(wpc.*30)./(pi); %Rev/Min
%Maximum Torque Tranferable (Without Slip)
MPMax=(Tp1-Tp0).*(Rp./12); %Maximum torque through shift without slipping (Ft.*lbs)

%% Renaming
TpE=Tp;
TsE=Ts;

%% Choosing Viable Combination


