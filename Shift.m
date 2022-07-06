function [TpShift,TsShift,AlphaShift,BetaShift,Tp1Shift,Tp0Shift,CpxShift,FpxShift,FpsShift,FflyxShift,FflyShift,wpcShift,MPMaxShift,FxtsShift,FytsShift,FHelixShift,FsShift,FsxShift,CsxShift,Ts0Shift,Ts1Shift,MSMaxShift,EffsShift] = Shift(n,Hds,dWs,Tv,Rp,Rs,R,X1,X2,Y2,U,Uep,Ues,MBelt,BeltSH,Ufly,cc,Kc,Theta,Phi,Kp,Xp0,Delta,Mfly,Rfly,Mlink,Rlink,Xt0,Kt,Yt0,Lambda,Eta,Rr)

%% Shift Condition
%Design Power
Hd = Hds; %Design power (hp)
%Angular Velocity
Wp = dWs; %Primary angular velocity (RPM)
Ws=Wp./Rs; %Secondary angular velocity (RPM)
%Torque at Desired RPM
Tp=(Hd.*5252)./Wp; %Primary Torque (ft.*lbs)
Ts=Tp.*R; %Torque at secondary through shift (ft.*lbs)
%% Belt Calculation
[Alpha,Beta] = Belt(n,Rp,Rs,cc);

%% Primary and Secondary Calculation

[Fxts,Fyts,FHelix,Fs,Fsx,Csx,Ts0,Ts1,MSMax,Effs] = Secondary(n,MBelt,Ws,Tv,Ts,X2,Y2,Rs,Phi,Beta,BeltSH,Ues,Xt0,Kt,Yt0,Lambda,Eta,Rr);
[Tp1,Tp0,Cpx,Fpx,Fps,Fflyx,Ffly,wpc,MPMax] = Primary(n,Tp,MBelt,Ts1,Wp,X1,Rp,Alpha,BeltSH,Uep,Ufly,Theta,Kp,Xp0,Delta,Mfly,Rfly,Mlink,Rlink);
    
    %Compiling Data Points
    %Primary
    Tp1Shift=Tp1;
    Tp0Shift=Tp0;
    CpxShift=Cpx;
    FpxShift=Fpx;
    FpsShift=Fps;
    FflyxShift=Fflyx;
    FflyShift=Ffly;
    wpcShift=wpc;
    MPMaxShift=MPMax;
    %Secondary
    FxtsShift=Fxts;
    FytsShift=Fyts;
    FHelixShift=FHelix;
    FsShift=Fs;
    FsxShift=Fsx;
    CsxShift=Csx;
    Ts0Shift=Ts0;
    Ts1Shift=Ts1;
    MSMaxShift=MSMax;
    EffsShift=Effs;

%% Renaming
TpShift=Tp;
TsShift=Ts;
AlphaShift=Alpha;
BetaShift=Beta;
