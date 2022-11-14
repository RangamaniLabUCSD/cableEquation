%% Passive Cable; trying to fit experimental as continuous function
%calculating passive cable with experimental input
%example for a cable of length 25um, but same format for different lengths, L
% different commented out portions run the cable equation for different parameter variations

%%%fit with exponential decay

close all
clear
clc

pathname = fileparts('autoPrintResults/');

%load experimental stuff
exper2 = load('prop4Miriam.mat');
allData = exper2.Prop4Miriam;
expDist = 0:99;
Vexp = allData.ASASP3ER_fxn_dist_mV;
VexpectedExp = allData.expected_mV;


avgMat = zeros(100,300); %x,t
%time is every 0.1 s for 30s
%x is every 0.5 um, so total of 50 um
for k = 1:100
   avgMat(k,:) = allData.windows(k).Alexa594_stats.avg;
end

totalInject = zeros(100,251);
totalInject(:,:) = avgMat(:,50:end); %take only first 50 um
currentX = [0:0.5:49.5];
currentT = [0:0.1:25];%%%%Only want from 5 to 30 seconds!

figure%%Just plot all temporal dynamics
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);
for xspot = 1:length(currentX)
    plot(currentT,totalInject(xspot,:))
    hold on
    xlim([0 3])
end

hold off
set(gcf,'pos',[0 0 1000 600])
ylabel('Fluorescence')
xlabel('Time [s]')
title('All Alexa 594 traces')
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% pngfile = fullfile(pathname, 'Alexa-allXTracesOverTime.png');
% saveas(gcf, pngfile);


%fit max temporal
tableMaxTempValue= zeros(length(currentX),2);
% for xspot = 1:length(currentX)
%     tableMaxTempValue(xspot) = max(totalInject(xspot,:));
% end
indexMax = zeros(length(currentX),1);
for xspot = 1:length(currentX)
    [maxVal, indexOfMax] = max(totalInject(xspot,:));
    tableMaxTempValue(xspot,1) = maxVal;
    indexMax(xspot) = indexOfMax;
    xForfit = length(currentT(indexOfMax:end));
    %f = fit(tspan(indexOfMax:end)',Allca(n,indexOfMax:end,i)','exp1');
    %unshifted
    %shifted
    fdecay = fit(currentT(1:xForfit).',totalInject(xspot,indexOfMax:end).','exp1');
    tableMaxTempValue(xspot,2) = fdecay.b;
end
% figure
% plot(currentX,tableMaxTempValue(:,1))
% figure
% plot(currentX,tableMaxTempValue(:,2))

%fit maxes wrt x
[MaxFitwrtX, gofMax] = fit(currentX.', tableMaxTempValue(:,1),'poly4');
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);
plot(MaxFitwrtX,currentX,tableMaxTempValue(:,1))
maxTrendEq=sprintf('y=%.4f x^4+%.3f x^3+%.3f x^2+%.3f x + %.3f',MaxFitwrtX.p1,MaxFitwrtX.p2,MaxFitwrtX.p3,MaxFitwrtX.p4,MaxFitwrtX.p5);
htrendlinetext=text(1,-25,maxTrendEq);%,'units','normalized');
set(gcf,'pos',[0 0 1000 600])
ylabel('Maximum Fluorescence')
xlabel('Distance [\mum]')
title('Polynomial Fit of Maximums to Distance')
legend('Data','Fit')
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% pngfile = fullfile(pathname, 'Alexa-FitMaxVsX.png');
% saveas(gcf, pngfile);

%fit decay wrt x
[DecayFitwrtX, gofDecay] = fit(currentX.', tableMaxTempValue(:,2),'poly4');
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);
plot(DecayFitwrtX,currentX,tableMaxTempValue(:,2))
set(gcf,'pos',[0 0 1000 600])
decayTrendEq=sprintf('y=%.4f x^4+%.3f x^3+%.3f x^2+%.3f x + %.3f',DecayFitwrtX.p1,DecayFitwrtX.p2,DecayFitwrtX.p3,DecayFitwrtX.p4,DecayFitwrtX.p5);
htrendlinetext=text(1,-1.75,decayTrendEq);%,'units','normalized');
ylabel('Maximum Fluorescence')
xlabel('Distance [\mum]')
title('Polynomial Fit of Decays to Distance')
legend({'Data','Fit'},'Location','east')
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% pngfile = fullfile(pathname, 'Alexa-FitDecayVsX.png');
% saveas(gcf, pngfile);

paras.p1 = MaxFitwrtX.p1;
paras.p2 = MaxFitwrtX.p2;
paras.p3 = MaxFitwrtX.p3;
paras.p4 = MaxFitwrtX.p4;
paras.p5 = MaxFitwrtX.p5;
paras.p1b = DecayFitwrtX.p1;
paras.p2b = DecayFitwrtX.p2;
paras.p3b = DecayFitwrtX.p3;
paras.p4b = DecayFitwrtX.p4;
paras.p5b = DecayFitwrtX.p5;

% figure
% for xspot = 1:length(currentX)
%     plot(currentT,tableMaxTempValue(xspot,1)*exp(tableMaxTempValue(xspot,2)*currentT))
%     hold on
%     xlim([0 5])
% end
% hold off

time = [0:0.01:0.5];
Fitfirst5 = tableMaxTempValue(xspot,1)*exp(tableMaxTempValue(xspot,2)*(0.5 - time));
time = [0.5:0.01:5];
Fitsecondpart = tableMaxTempValue(xspot,1)*exp(tableMaxTempValue(xspot,2)*(time-0.5));

%Current fit style
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);
for xspot = 1:length(currentX)
    time = [0:0.01:0.5];
    plot(time,tableMaxTempValue(xspot,1)*exp(tableMaxTempValue(xspot,2)*(0.5 - time)))
    hold on
    xlim([0 5])
end
for xspot = 1:length(currentX)
    time = [0.5:0.01:5];
    plot(time,tableMaxTempValue(xspot,1)*exp(tableMaxTempValue(xspot,2)*(time-0.5)))
    hold on
    xlim([0 3])
end
hold off
set(gcf,'pos',[0 0 1000 600])
ylabel('Model Fluorescence')
xlabel('Time [s]')
title('Model input for Fluorescence')
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% pngfile = fullfile(pathname, 'Alexa-allXTracesOverTime-Model.png');
% saveas(gcf, pngfile);



%have loaded the experimental

L = 25;      % cable length, um
Tend =5;     % duration of integration, s
dtstep = 0.001; % time integration step, s
dxstep = 0.005;%%0.005; 00;% space integration step, um
t = 0:dtstep:Tend;
x = 0:dxstep:L;% 10001 points

%to vary all 3 parameters
% aList = [0.025 0.05]; RmList = [1e6*(1e4)^2 1e7*(1e4)^2];
% RiList = [1e5*(1e4) 1e6*(1e4)];
% resultmaxes= zeros(length(x),length(aList),length(RmList),length(RiList));%save the soln and maxes for each variation
% figure
% for i = 1:length(aList)
%     for j = 1:length(RmList)
%         for k = 1:length(RiList)
%             paras.a = aList(i);%0.025;  % cable radius, um
%             paras.Rm = RmList(j);%1e7*(1e4)^2;  %Ohm*um2 membrane resistivity, Ohm*cm^2
%             paras.Cm = 1e-6/((1e4)^2);     % F/um2 1 uF/cm2 membrane capacitance, uF/cm^2
%             paras.Ri = RiList(k);%1e6*(1e4);   % Ohm*um; intracellular resistivity, Ohm*cm
%             paras.Iscale = 125;
%             [soln, maxes] = call_passCable_para(paras);
%             resultmaxes(:, i,j,k) = maxes(:,1);
%             plot(x, resultmaxes(:, i,j,k))
%             hold on
%             
%         end
%     end
% end
% %[soln, maxes] = call_passCable_para(paras);
% 
% 
% figure
% set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% for i = 1:length(aList)
%     for j = 1:length(RmList)
%         for k = 1:length(RiList)
%             plot(x, resultmaxes(:, i,j,k))
%             hold on
%             
%         end
%     end
% end
% plot(0:0.5:49.5,Vexp)
% plot(0:0.5:49.5,VexpectedExp)
% xlim([0 50])
% set(gcf,'pos',[0 0 1000 600])
% ylabel('Maximum Voltage [mV])')
% xlabel('Distance along ER [\mum]')
% title('Maximum Voltage in the ER')
% legend('a 0.25, Rm 1e14, Ri 1e9','a 0.25, Rm 1e14, Ri 1e10',.../
%     'a 0.25, Rm 1e15, Ri 1e9','a 0.25, Rm 1e15, Ri 1e10',.../
%     'a 0.5, Rm 1e14, Ri 1e9','a 0.5, Rm 1e14, Ri 1e10',.../
%     'a 0.5, Rm 1e15, Ri 1e9','a 0.5, Rm 1e15, Ri 1e10');
% set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);

%[soln, maxes] = call_passCable_para(paras);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ORIGINAL
% % % %just vary a - ORIGINAL
% % % aList = [0.020 0.025 0.030 0.035];%BASE RADIUS IS 25 nm!
% % % RmList = [1e12];% 1e15];%[1e7*(1e4)^2];
% % % RiList = [1e6];% 1e10];%[1e6*(1e4)];
% % % resultmaxesA= zeros(length(x),length(aList),length(RmList),length(RiList));%save the soln and maxes for each variation
% % % 
% % % for i = 1:length(aList)
% % %     for j = 1:length(RmList)
% % %         for k = 1:length(RiList)
% % %             paras.a = aList(i);%0.025;  % cable radius, um
% % %             paras.Rm = RmList(j);%1e7*(1e4)^2;  %Ohm*um2 membrane resistivity, Ohm*cm^2
% % %             paras.Cm = 1e-6/((1e4)^2);     % F/um2 1 uF/cm2 membrane capacitance, uF/cm^2
% % %             paras.Ri = RiList(k);%1e6*(1e4);   % Ohm*um; intracellular resistivity, Ohm*cm
% % %             paras.Iscale = 730;
% % %             [soln, maxes] = call_passCable_para(paras);
% % %             resultmaxesA(:, i,j,k) = maxes(:,1);
% % %             hold on
% % %         end
% % %     end
% % % end
% % % 
% % % figure
% % % set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% % % set(0,'defaultAxesFontSize', 28)
% % % set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% % % for i = 1:length(aList)
% % %     for j = 1:length(RmList)
% % %         for k = 1:length(RiList)
% % %             plot(x, resultmaxesA(:, i,j,k))
% % %             hold on
% % %             
% % %         end
% % %     end
% % % end
% % % plot(0:0.5:49.5,Vexp)
% % % plot(0:0.5:49.5,VexpectedExp)
% % % xlim([0 50])
% % % set(gcf,'pos',[0 0 1000 600])
% % % ylabel('Maximum Voltage [mV]')
% % % xlabel('Distance along ER [\mum]')
% % % title('Maximum Voltage in the ER for different ER radius')
% % % legend('20 nm','25 nm','30 nm','35 nm','Experimental Voltage','Predicted from Caffeine')
% % % %legend('5nm','10nm','25nm','35nm','Experimental Voltage','Predicted from Caffeine')
% % % 
% % % %legend('5nm, Rm 1e12, Ri 1e6','10nm, Rm 1e12, Ri 1e6','25nm, Rm 1e12, Ri 1e6','30nm, Rm 1e12, Ri 1e6');
% % % % legend('5nm, Rm low, Ri high','5nm, Rm low, Ri low','5nm, Rm low, Ri high','5nm, Rm high, Ri high',.../
% % % %     '10nm, Rm low, Ri high','10nm, Rm low, Ri low','10nm, Rm low, Ri high','10nm, Rm high, Ri high',.../
% % % %     '25nm, Rm low, Ri high','25nm, Rm low, Ri low','25nm, Rm low, Ri high','25nm, Rm high, Ri high',.../
% % % %     '30nm, Rm low, Ri high','30nm, Rm low, Ri low','30nm, Rm low, Ri high','30nm, Rm high, Ri high');
% % % %legend('5nm','10nm','25nm','35nm','50nm');
% % % set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% % % set(0,'defaultAxesFontSize', 28)
% % % set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% % % %pngfile = fullfile(pathname, 'Voltage-maxVoltageVsX-BaseModelandExp.png');
% % % % pngfile = fullfile(pathname, 'Voltage-maxVoltageVsX-ModelandExp-varyA-ORIGINAL.png');
% % % % saveas(gcf, pngfile);

% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%MONAI BPJ
% % % %just vary a - MONAI
% % % aList = [0.020 0.025 0.030 0.035];%BASE RADIUS IS 25 nm!
% % % RmList = [3e12];% 1e15];%[1e7*(1e4)^2];
% % % RiList = [2e6];% 1e10];%[1e6*(1e4)];
% % % resultmaxesA= zeros(length(x),length(aList),length(RmList),length(RiList));%save the soln and maxes for each variation
% % % 
% % % for i = 1:length(aList)
% % %     for j = 1:length(RmList)
% % %         for k = 1:length(RiList)
% % %             paras.a = aList(i);%0.025;  % cable radius, um
% % %             paras.Rm = RmList(j);%1e7*(1e4)^2;  %Ohm*um2 membrane resistivity, Ohm*cm^2
% % %             paras.Cm = 1.5e-6/((1e4)^2);     % F/um2 1 uF/cm2 membrane capacitance, uF/cm^2
% % %             paras.Ri = RiList(k);%1e6*(1e4);   % Ohm*um; intracellular resistivity, Ohm*cm
% % %             paras.Iscale = 360;
% % %             [soln, maxes] = call_passCable_para(paras);
% % %             resultmaxesA(:, i,j,k) = maxes(:,1);
% % %             hold on
% % %         end
% % %     end
% % % end
% % % 
% % % figure
% % % set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% % % set(0,'defaultAxesFontSize', 28)
% % % set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% % % for i = 1:length(aList)
% % %     for j = 1:length(RmList)
% % %         for k = 1:length(RiList)
% % %             plot(x, resultmaxesA(:, i,j,k))
% % %             hold on
% % %             
% % %         end
% % %     end
% % % end
% % % plot(0:0.5:49.5,Vexp)
% % % plot(0:0.5:49.5,VexpectedExp)
% % % xlim([0 50])
% % % set(gcf,'pos',[0 0 1000 600])
% % % ylabel('Maximum Voltage [mV]')
% % % xlabel('Distance along ER [\mum]')
% % % title('Maximum Voltage in the ER for different ER radius')
% % % legend('20 nm','25 nm','30 nm','35 nm','Experimental Voltage','Predicted from Caffeine')
% % % %legend('5nm','10nm','25nm','35nm','Experimental Voltage','Predicted from Caffeine')
% % % 
% % % %legend('5nm, Rm 1e12, Ri 1e6','10nm, Rm 1e12, Ri 1e6','25nm, Rm 1e12, Ri 1e6','30nm, Rm 1e12, Ri 1e6');
% % % % legend('5nm, Rm low, Ri high','5nm, Rm low, Ri low','5nm, Rm low, Ri high','5nm, Rm high, Ri high',.../
% % % %     '10nm, Rm low, Ri high','10nm, Rm low, Ri low','10nm, Rm low, Ri high','10nm, Rm high, Ri high',.../
% % % %     '25nm, Rm low, Ri high','25nm, Rm low, Ri low','25nm, Rm low, Ri high','25nm, Rm high, Ri high',.../
% % % %     '30nm, Rm low, Ri high','30nm, Rm low, Ri low','30nm, Rm low, Ri high','30nm, Rm high, Ri high');
% % % %legend('5nm','10nm','25nm','35nm','50nm');
% % % set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% % % set(0,'defaultAxesFontSize', 28)
% % % set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% % % %pngfile = fullfile(pathname, 'Voltage-maxVoltageVsX-BaseModelandExp.png');
% % % pngfile = fullfile(pathname, 'Voltage-maxVoltageVsX-ModelandExp-varyA-MONAI.png');
% % % saveas(gcf, pngfile);

% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ROTH
% % % %just vary a - ROTH
% % % aList = [0.020 0.025 0.030 0.035];%BASE RADIUS IS 25 nm!
% % % RmList = [12.2e12];% 1e15];%[1e7*(1e4)^2];
% % % RiList = [1.15e6];% 1e10];%[1e6*(1e4)];
% % % resultmaxesA= zeros(length(x),length(aList),length(RmList),length(RiList));%save the soln and maxes for each variation
% % % 
% % % for i = 1:length(aList)
% % %     for j = 1:length(RmList)
% % %         for k = 1:length(RiList)
% % %             paras.a = aList(i);%0.025;  % cable radius, um
% % %             paras.Rm = RmList(j);%1e7*(1e4)^2;  %Ohm*um2 membrane resistivity, Ohm*cm^2
% % %             paras.Cm = 0.77e-6/((1e4)^2);     % F/um2 1 uF/cm2 membrane capacitance, uF/cm^2
% % %             paras.Ri = RiList(k);%1e6*(1e4);   % Ohm*um; intracellular resistivity, Ohm*cm
% % %             paras.Iscale = 595;
% % %             [soln, maxes] = call_passCable_para(paras);
% % %             resultmaxesA(:, i,j,k) = maxes(:,1);
% % %             hold on
% % %         end
% % %     end
% % % end
% % % 
% % % figure
% % % set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% % % set(0,'defaultAxesFontSize', 28)
% % % set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% % % for i = 1:length(aList)
% % %     for j = 1:length(RmList)
% % %         for k = 1:length(RiList)
% % %             plot(x, resultmaxesA(:, i,j,k))
% % %             hold on
% % %             
% % %         end
% % %     end
% % % end
% % % plot(0:0.5:49.5,Vexp)
% % % plot(0:0.5:49.5,VexpectedExp)
% % % xlim([0 50])
% % % set(gcf,'pos',[0 0 1000 600])
% % % ylabel('Maximum Voltage [mV]')
% % % xlabel('Distance along ER [\mum]')
% % % title('Maximum Voltage in the ER for different ER radius')
% % % legend('20 nm','25 nm','30 nm','35 nm','Experimental Voltage','Predicted from Caffeine')
% % % %legend('5nm','10nm','25nm','35nm','Experimental Voltage','Predicted from Caffeine')
% % % 
% % % %legend('5nm, Rm 1e12, Ri 1e6','10nm, Rm 1e12, Ri 1e6','25nm, Rm 1e12, Ri 1e6','30nm, Rm 1e12, Ri 1e6');
% % % % legend('5nm, Rm low, Ri high','5nm, Rm low, Ri low','5nm, Rm low, Ri high','5nm, Rm high, Ri high',.../
% % % %     '10nm, Rm low, Ri high','10nm, Rm low, Ri low','10nm, Rm low, Ri high','10nm, Rm high, Ri high',.../
% % % %     '25nm, Rm low, Ri high','25nm, Rm low, Ri low','25nm, Rm low, Ri high','25nm, Rm high, Ri high',.../
% % % %     '30nm, Rm low, Ri high','30nm, Rm low, Ri low','30nm, Rm low, Ri high','30nm, Rm high, Ri high');
% % % %legend('5nm','10nm','25nm','35nm','50nm');
% % % set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% % % set(0,'defaultAxesFontSize', 28)
% % % set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% % % %pngfile = fullfile(pathname, 'Voltage-maxVoltageVsX-BaseModelandExp.png');
% % % pngfile = fullfile(pathname, 'Voltage-maxVoltageVsX-ModelandExp-varyA-ROTH.png');
% % % saveas(gcf, pngfile);

% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%MAJOR
% % % %just vary a - MAJOR
% % % aList = [0.020 0.025 0.030 0.035];%BASE RADIUS IS 25 nm!
% % % RmList = [16e12];% 1e15];%[1e7*(1e4)^2];
% % % RiList = [2.55e6];% 1e10];%[1e6*(1e4)];
% % % resultmaxesA= zeros(length(x),length(aList),length(RmList),length(RiList));%save the soln and maxes for each variation
% % % 
% % % for i = 1:length(aList)
% % %     for j = 1:length(RmList)
% % %         for k = 1:length(RiList)
% % %             paras.a = aList(i);%0.025;  % cable radius, um
% % %             paras.Rm = RmList(j);%1e7*(1e4)^2;  %Ohm*um2 membrane resistivity, Ohm*cm^2
% % %             paras.Cm = 0.75e-6/((1e4)^2);     % F/um2 1 uF/cm2 membrane capacitance, uF/cm^2
% % %             paras.Ri = RiList(k);%1e6*(1e4);   % Ohm*um; intracellular resistivity, Ohm*cm
% % %             paras.Iscale = 270;
% % %             [soln, maxes] = call_passCable_para(paras);
% % %             resultmaxesA(:, i,j,k) = maxes(:,1);
% % %             hold on
% % %         end
% % %     end
% % % end
% % % 
% % % figure
% % % set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% % % set(0,'defaultAxesFontSize', 28)
% % % set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% % % for i = 1:length(aList)
% % %     for j = 1:length(RmList)
% % %         for k = 1:length(RiList)
% % %             plot(x, resultmaxesA(:, i,j,k))
% % %             hold on
% % %             
% % %         end
% % %     end
% % % end
% % % plot(0:0.5:49.5,Vexp)
% % % plot(0:0.5:49.5,VexpectedExp)
% % % xlim([0 50])
% % % set(gcf,'pos',[0 0 1000 600])
% % % ylabel('Maximum Voltage [mV]')
% % % xlabel('Distance along ER [\mum]')
% % % title('Maximum Voltage in the ER for different ER radius')
% % % legend('20 nm','25 nm','30 nm','35 nm','Experimental Voltage','Predicted from Caffeine')
% % % %legend('5nm','10nm','25nm','35nm','Experimental Voltage','Predicted from Caffeine')
% % % 
% % % %legend('5nm, Rm 1e12, Ri 1e6','10nm, Rm 1e12, Ri 1e6','25nm, Rm 1e12, Ri 1e6','30nm, Rm 1e12, Ri 1e6');
% % % % legend('5nm, Rm low, Ri high','5nm, Rm low, Ri low','5nm, Rm low, Ri high','5nm, Rm high, Ri high',.../
% % % %     '10nm, Rm low, Ri high','10nm, Rm low, Ri low','10nm, Rm low, Ri high','10nm, Rm high, Ri high',.../
% % % %     '25nm, Rm low, Ri high','25nm, Rm low, Ri low','25nm, Rm low, Ri high','25nm, Rm high, Ri high',.../
% % % %     '30nm, Rm low, Ri high','30nm, Rm low, Ri low','30nm, Rm low, Ri high','30nm, Rm high, Ri high');
% % % %legend('5nm','10nm','25nm','35nm','50nm');
% % % set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% % % set(0,'defaultAxesFontSize', 28)
% % % set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% % % %pngfile = fullfile(pathname, 'Voltage-maxVoltageVsX-BaseModelandExp.png');
% % % pngfile = fullfile(pathname, 'Voltage-maxVoltageVsX-ModelandExp-varyA-MAJOR.png');
% % % saveas(gcf, pngfile);

% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Large diff
%Vary a Rm and Ri for larger difference
aList = [0.020 0.025];%BASE RADIUS IS 25 nm!
RmList = [1e12 1e15];% 1e15];%[1e7*(1e4)^2];
RiList = [1e6 1e8];% 1e10];%[1e6*(1e4)];
resultmaxesA= zeros(length(x),length(aList),length(RmList),length(RiList));%save the soln and maxes for each variation

for i = 1:length(aList)
    for j = 1:length(RmList)
        for k = 1:length(RiList)
            paras.a = aList(i);%0.025;  % cable radius, um
            paras.Rm = RmList(j);%1e7*(1e4)^2;  %Ohm*um2 membrane resistivity, Ohm*cm^2
            paras.Cm = 0.75e-6/((1e4)^2);     % F/um2 1 uF/cm2 membrane capacitance, uF/cm^2
            paras.Ri = RiList(k);%1e6*(1e4);   % Ohm*um; intracellular resistivity, Ohm*cm
            paras.Iscale = 730;
            [soln, maxes] = call_passCable_para(paras);
            resultmaxesA(:, i,j,k) = maxes(:,1);
            hold on
        end
    end
end

figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);
for i = 1:length(aList)
    for j = 1:length(RmList)
        for k = 1:length(RiList)
            plot(x, resultmaxesA(:, i,j,k))
            hold on
            
        end
    end
end
plot(0:0.5:49.5,Vexp)
plot(0:0.5:49.5,VexpectedExp)
xlim([0 50])
set(gcf,'pos',[0 0 1000 600])
ylabel('Maximum Voltage [mV]')
xlabel('Distance along ER [\mum]')
title('Maximum Voltage in the ER for different ER radius')
legend('20nm, Rm 1e12, Ri 1e6','20nm, Rm 1e12, Ri 1e8','20nm, Rm 1e15, Ri 1e6','20nm, Rm 1e15, Ri 1e8',.../
    '25nm, Rm 1e12, Ri 1e6','25nm, Rm 1e12, Ri 1e8','25nm, Rm 1e15, Ri 1e6','25nm, Rm 1e15, Ri 1e8',.../
    'Experimental Voltage','Predicted from Caffeine');
%legend('5nm','10nm','25nm','35nm','50nm');
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% % % %pngfile = fullfile(pathname, 'Voltage-maxVoltageVsX-BaseModelandExp.png');
% % % pngfile = fullfile(pathname, 'Voltage-maxVoltageVsX-ModelandExp-varyARmRi.png');
% % % saveas(gcf, pngfile);
% % % 
% % % 
% % % %whole mulitplication values for the "beta" in beta*Rm/(a*Tau) so below is Iscale*beta
% % % Originalbeta = (1.0417e-16)*730;
% % % Monaibeta = (1.0417e-16)*360;
% % % Rothbeta = (1.0417e-16)*595;
% % % Majorbeta = (1.0417e-16)*270;

function [soln,maxValoverTimeModel] = call_passCable_para(paras)
%E = 5;      % shock field, V/cm
L = 25;      % cable length, um
Tend =5;     % duration of integration, s
dtstep = 0.001; % time integration step, s
dxstep = 0.005;%%0.005; 00;% space integration step, um
% tau = Rm*Cm;              % membrane time constant, s
% lambda = sqrt((a*Rm)/(2*Ri));   % space constant, um

%x = linspace(0,dxstep,L);
t = 0:dtstep:Tend;
tbreak = 0.5;
x = 0:dxstep:L;% 10001 points
t1 = 0:dtstep:tbreak;%linspace(0,dtstep,tbreak); 501 points
t2 = tbreak:dtstep:Tend;%linspace(tbreak,dtstep,Tend); 4501 points
m = 0;

sol1 = pdepe(m,@(x,t,u,dudx)pdefun1(x,t,u,dudx,paras),@icfun,@bcfun,x,t1);

newIC(:,1) = sol1(end,:).';
global counter
counter=0;
sol2 = pdepe(m,@(x,t,u,dudx)pdefun(x,t,u,dudx,paras),@(x)ic2(x,newIC),@bcfun,x,t2);
soln = [sol1(1:end-1,:); sol2];

figure
colormap hot
imagesc(x,t,soln)
colorbar
h = colorbar;
h.Title.String = 'mV'; %ylabel(h, '#/\mum^2')
xlabel('Distance [\mum]')
ylabel('Time [s]')
title('Cable equation')


%find max value of our solution
maxValoverTimeModel= zeros(length(x),2);
for i = 1:length(x) 
    [valMax, indexMax] = max(soln(:,i));
    maxValoverTimeModel(i,1) = valMax; %sol is time then x
    maxValoverTimeModel(i,2) = indexMax;
end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [c,f,s] = pdefun1(x,t,u,dudx,paras)

%%%%%%%%%%%%%%%%%%%%%%
a = paras.a;%0.025;  % cable radius, um
Rm = paras.Rm;%1e7*(1e4)^2;  %Ohm*um2 membrane resistivity, Ohm*cm^2
Cm = paras.Cm;%1e-6/((1e4)^2);     % F/um2 1 uF/cm2 membrane capacitance, uF/cm^2
Ri = paras.Ri;%1e6*(1e4);   % Ohm*um; intracellular resistivity, Ohm*cm
Iscale = paras.Iscale;


tau = Rm*Cm;              % membrane time constant, s
lambda = sqrt((a*Rm)/(2*Ri));   % space constant, um
c = 1;
f = (lambda^2/tau)*dudx;
p1 =  paras.p1;
p2 =  paras.p2;
p3 =  paras.p3;
p4 =  paras.p4;
p5 =  paras.p5;
aval = p1*x^4 + p2*x^3 + p3*x^2 + p4*x + p5;%max at x
p1b =  paras.p1b;
p2b =  paras.p2b;
p3b =  paras.p3b;
p4b =  paras.p4b;
p5b =  paras.p5b;
bval = p1b*x^4 + p2b*x^3 + p3b*x^2 + p4b*x + p5b;%decay constant at x
Ivalue = aval*exp(bval*(0.5-t));
betaCon = 0.4167*0.025*1e-6/((1e4)^2);
I0 = (betaCon*Rm/(a*tau))*Ivalue;
s = -u/tau + Iscale*I0;%Iscale*Ivalue/300; %215
end

function [c,f,s] = pdefun(x,t,u,dudx,paras)

a = paras.a;%0.025;  % cable radius, um
Rm = paras.Rm;%1e7*(1e4)^2;  %Ohm*um2 membrane resistivity, Ohm*cm^2
Cm = paras.Cm;%1e-6/((1e4)^2);     % F/um2 1 uF/cm2 membrane capacitance, uF/cm^2
Ri = paras.Ri;%1e6*(1e4);   % Ohm*um; intracellular resistivity, Ohm*cm
Iscale = paras.Iscale;

tau = Rm*Cm;              % membrane time constant, s
lambda = sqrt((a*Rm)/(2*Ri));   % space constant, um
c = 1;
f = (lambda^2/tau)*dudx;
p1 =  paras.p1;
p2 =  paras.p2;
p3 =  paras.p3;
p4 =  paras.p4;
p5 =  paras.p5;
aval = p1*x^4 + p2*x^3 + p3*x^2 + p4*x + p5;%max at x
p1b =  paras.p1b;
p2b =  paras.p2b;
p3b =  paras.p3b;
p4b =  paras.p4b;
p5b =  paras.p5b;
bval = p1b*x^4 + p2b*x^3 + p3b*x^2 + p4b*x + p5b;%decay constant at x
Ivalue = aval*exp(bval*(t-0.5));
betaCon = 0.4167*0.025*1e-6/((1e4)^2);
I0 = (betaCon*Rm/(a*tau))*Ivalue;
s = -u/tau + Iscale*I0;%Iscale*Ivalue/300;
end

function u0 = icfun(x)
u0 = 0;
end

function u0 = ic2(x,newIC)
% global init_cond_2
% global x_vector;
% % find the index of the x value pdepe wants to call
% [R,C] = find(x_vector==x,1,'first');
% %use the index to return the value of interest
% u0 = init_cond_2(R,C);
global counter
counter=counter+1;
u0=newIC(counter,1);
end


function [pl,ql,pr,qr] = bcfun(xl,ul,xr,ur,t)
pl = 0; %ul if dirichlet at 0
ql = 1; %neumann boundary
pr = ur;%right handside held at 0
qr = 0;
end