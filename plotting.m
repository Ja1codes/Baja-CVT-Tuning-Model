function plotting(V,n,dWe,R,wpc,dWs,MPMaxShift,TpShift,Tp0Shift,Tp1Shift,FpxShift,MSMaxShift,TsShift,Ts0Shift,Ts1Shift,FsxShift)



%% Plotting

%% Engine Speed Vs. Shift Ratio
figure
plot(R',wpc')
grid on

set (gca,'xdir','reverse')
set(gca,'FontSize',20)
hold on

%Plot Labels
title('Engine Speed Vs. Shift Ratio')
xlabel('Shift Ratio')
ylabel('Engine Speed [RPM]')
ylim([0 5000])

%Reference Markers
y1=yline(dWs,'--',{'Desired Shift RPM'},'fontsize',20);
y1.LabelVerticalAlignment='middle';
y1.LabelHorizontalAlignment='center';
y1=yline(dWe,'--',{'Desired Engagement RPM'},'fontsize',20);
y1.LabelVerticalAlignment='middle';
y1.LabelHorizontalAlignment='center';
%Reference Lines
x1=xline(1,'--',{'Overdrive'},'fontsize',20);
x1.LabelVerticalAlignment='middle';
x1.LabelHorizontalAlignment='center';

%% Primary

%% Torque Received Vs. Maximum Torque Tranferrable
figure
plot(R,MPMaxShift)
grid on
hold on
%Plot Axes
set(gca,'FontSize',20)
set(gca,'xdir','reverse')
title('Tranferrable Torque at Primary Through Shift')
xlabel('Shift Ratio')
ylabel('Tranferrable Torque (Ft.*lbs)')
ylim([0 50])
xlim([R(n) R(1)])
%Reference Markers
y1=yline(TpShift,'--',{'Minimum Requirement'},'fontsize',20); %Minimum Torque
y1.LabelVerticalAlignment='middle';
y1.LabelHorizontalAlignment='center';

%% Tension Through Shift
figure
plot(R,Tp0Shift,'--',R,Tp1Shift)
grid on
hold on
%Plot Axes
set(gca,'FontSize',20)
set(gca,'xdir','reverse')
title('Belt Tension Through Shift at Primary')
xlabel('Shift Ratio')
ylabel('Belt Tension (Lbf)')
ylim([-100 200])
xlim([R(n) R(1)])
%Text Box
str={'Dashed Line: Slack Side Tension','Solid Line: Taught Side Tension'};
dim=[0.7 0.6 0.3 0.3];
t=annotation('textbox',dim,'String',str,'FitBoxToText','on','fontsize',20);

%% Clamping Force Through Shift
figure
plot(R,FpxShift)
grid on
%Plot Axes
set(gca,'FontSize',20)
set(gca,'xdir','reverse')
title('Total Clamping Force Through Shift at Primary')
xlabel('Shift Ratio')
ylabel('Clamping Force (Lbf)')
ylim([0 200])
xlim([R(n) R(1)])

%% Vehicle Speed Vs. Engine Speed
figure
plot(V',wpc')
grid on
hold on
%Plot Axes
set(gca,'FontSize',20)
title('Engine Speed Vs. Vehicle Speed')
xlabel('Vehicle Speed [MPH]')
ylabel('Engine Speed (RPM)')
%ylim([0 5000])
xlim([0 max(V(:,n))])
%Reference Markers
y1=yline(dWs,'--',{'Desired Shift RPM'},'fontsize',20);
y1.LabelVerticalAlignment='middle';
y1.LabelHorizontalAlignment='center';
y1=yline(dWe,'--',{'Desired Engagement RPM'},'fontsize',20);
y1.LabelVerticalAlignment='middle';
y1.LabelHorizontalAlignment='center';

%% Vehicle Speed Vs. Shift Ratio
figure
plot(R,V')
grid on
set (gca,'xdir','reverse')
set(gca,'FontSize',20)
%Plot Axes
title('Vehicle Speed Vs. Shift Ratio')
xlabel('Shift Ratio')
ylabel('Vehicle Speed [MPH]')
%xlim([.5 4])
%Reference Lines
x1=xline(1,'--',{'Overdrive'},'fontsize',20);
x1.LabelVerticalAlignment='middle';
x1.LabelHorizontalAlignment='center';


%% Secondary
%% Torque Received Vs. Maximum Torque Tranferrable
figure
plot(R,MSMaxShift)
grid on
hold on
%Plot Axes
set(gca,'FontSize',20)
set(gca,'xdir','reverse')
title('Tranferrable Torque at Secondary Through Shift')
xlabel('Shift Ratio')
ylabel('Tranferrable Torque (Ft.*lbs)')
ylim([0 80])
xlim([R(n) R(1)])
%Reference Markers
plot(R,TsShift,'--')
text(2.25,20,'-- = Minimum Requirement','FontSize',20);
%label(R,'Minimum Requirement','slope','right')
set(gca,'FontSize',20)
%% Tension Through Shift
figure
plot(R,Ts0Shift,'--',R,Ts1Shift)
grid on
hold on
%Plot Axes
set(gca,'FontSize',20)
set(gca,'xdir','reverse')
title('Belt Tension Through Shift at Secondary')
xlabel('Shift Ratio')
ylabel('Belt Tension (Lbf)')
ylim([-100 200])
xlim([R(n) R(1)])
%Text Box
str={'Dashed Line: Slack Side Tension','Solid Line: Taught Side Tension'};
dim=[0.7 0.6 0.3 0.3];
t=annotation('textbox',dim,'String',str,'FitBoxToText','on','fontsize',20);
%% Clamping Force Through Shift
figure
plot(R,FsxShift)
grid on
%Plot Axes
set(gca,'FontSize',20)
set(gca,'xdir','reverse')
title('Total Clamping Force Through Shift at Secondary')
xlabel('Shift Ratio')
ylabel('Clamping Force (Lbf)')
ylim([0 100])
xlim([R(n) R(1)])




%{




%% Primary
%% Torque Received Vs. Maximum Torque Tranferrable
figure
plot(R,MPMaxShift)
grid on
hold on
%Plot Axes
set(gca,'FontSize',20)
set(gca,'xdir','reverse')
title('Tranferrable Torque at Primary Through Shift')
xlabel('Shift Ratio')
ylabel('Tranferrable Torque (Ft.*lbs)')
ylim([0 50])
xlim([R(n) R(1)])
%Reference Markers
y1=yline(TpShift,'--',{'Minimum Requirement'},'fontsize',20); %Minimum Torque
y1.LabelVerticalAlignment='middle';
y1.LabelHorizontalAlignment='center';

%% Tension Through Shift
figure
plot(R,Tp0Shift,'--',R,Tp1Shift)
grid on
hold on
%Plot Axes
set(gca,'FontSize',20)
set(gca,'xdir','reverse')
title('Belt Tension Through Shift at Primary')
xlabel('Shift Ratio')
ylabel('Belt Tension (Lbf)')
ylim([-100 200])
xlim([R(n) R(1)])
%Text Box
str={'Dashed Line: Slack Side Tension','Solid Line: Taught Side Tension'};
dim=[0.7 0.6 0.3 0.3];
t=annotation('textbox',dim,'String',str,'FitBoxToText','on','fontsize',20);

%% Clamping Force Through Shift
figure
plot(R,FpxShift)
grid on
%Plot Axes
set(gca,'FontSize',20)
set(gca,'xdir','reverse')
title('Total Clamping Force Through Shift at Primary')
xlabel('Shift Ratio')
ylabel('Clamping Force (Lbf)')
ylim([0 200])
xlim([R(n) R(1)])

%% Secondary
%% Torque Received Vs. Maximum Torque Tranferrable
figure
plot(R,MSMaxShift)
grid on
hold on
68
%Plot Axes
set(gca,'FontSize',20)
set(gca,'xdir','reverse')
title('Tranferrable Torque at Secondary Through Shift')
xlabel('Shift Ratio')
ylabel('Tranferrable Torque (Ft.*lbs)')
ylim([0 80])
xlim([R(n) R(1)])
%Reference Markers
plot(R,TsShift,'--')
text(2.25,20,'-- = Minimum Requirement','FontSize',20);
%label(R,'Minimum Requirement','slope','right')
set(gca,'FontSize',20)
%% Tension Through Shift
figure
plot(R,Ts0Shift,'--',R,Ts1Shift)
grid on
hold on
%Plot Axes
set(gca,'FontSize',20)
set(gca,'xdir','reverse')
title('Belt Tension Through Shift at Secondary')
xlabel('Shift Ratio')
ylabel('Belt Tension (Lbf)')
ylim([-100 200])
xlim([R(n) R(1)])
%Text Box
str={'Dashed Line: Slack Side Tension','Solid Line: Taught Side Tension'};
dim=[0.7 0.6 0.3 0.3];
t=annotation('textbox',dim,'String',str,'FitBoxToText','on','fontsize',20);
%% Clamping Force Through Shift
figure
plot(R,FsxShift)
grid on
%Plot Axes
set(gca,'FontSize',20)
set(gca,'xdir','reverse')
title('Total Clamping Force Through Shift at Secondary')
xlabel('Shift Ratio')
ylabel('Clamping Force (Lbf)')
ylim([0 100])
xlim([R(n) R(1)])

%}
