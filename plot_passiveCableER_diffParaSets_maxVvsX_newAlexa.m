%% Passive Cable; plotting different parameter sets together
% passive cable
% commented out sections plot for different mat files

%%%fit with exponential decay

close all
clear
clc

colors = {[0, 0.4470, 0.7410]; [0.8500, 0.3250, 0.0980];  .../ %blue
          [0.9290, 0.6940, 0.1250]; [0.4940, 0.1840, 0.5560]	;  .../ %green
          [0.4660, 0.6740, 0.1880];  [0.3010, 0.7450, 0.9330];  .../ %red
          [0.6350, 0.0780, 0.1840]	;  [0, 0.75, 0.75];.../
          [0.25, 0.25, 0.25]; [0.25, 0.25, 0.25]*3};%;  .../ %pink/purple
          
%load data stuff order is 20, 25, 30, 35 nm
ORIGINAL = load('resultsMaxVsX-varyA-ORIGINAL-25um.mat');
ORIGINAL25= ORIGINAL.resultmaxesA;
ORIGINAL = load('resultsMaxVsX-varyA-ORIGINAL-50um.mat');
ORIGINAL50= ORIGINAL.resultmaxesA;
ORIGINAL = load('resultsMaxVsX-varyA-ORIGINAL-100um.mat');
ORIGINAL100= ORIGINAL.resultmaxesA;

ORIGINAL = load('resultsMaxVsX-varyARmRi-ORIGINAL-25um.mat');
ORIGINALVar25= ORIGINAL.resultmaxesA;
ORIGINAL = load('resultsMaxVsX-varyARmRi-ORIGINAL-50um.mat');
ORIGINALVar50= ORIGINAL.resultmaxesA;
ORIGINAL = load('resultsMaxVsX-varyARmRi-ORIGINAL-100um.mat');
ORIGINALVar100= ORIGINAL.resultmaxesA;
% MONAI = load('resultsMaxVsX-varyA-MONAI.mat');
% MONAI= MONAI.resultmaxesA;
% ROTH = load('resultsMaxVsX-varyA-ROTH.mat');
% ROTH= ROTH.resultmaxesA;
% MAJOR = load('resultsMaxVsX-varyA-MAJOR.mat');
% MAJOR= MAJOR.resultmaxesA;
% 
% ORIGINALVar = load('resultsMaxVsX-varyARmRi-Original.mat');
% ORIGINALVar= ORIGINALVar.resultmaxesA;

%load experimental stuff
exper2 = load('prop4Miriam.mat');
allData = exper2.Prop4Miriam;
expDist = 0:99;
Vexp = allData.ASASP3ER_fxn_dist_mV;
VexpectedExp = allData.expected_mV;
pathname = fileparts('autoPrintResults/');

L25 = 25;
L50 = 50;      % cable length, um
L100 = 100;
Tend =5;     % duration of integration, s
dtstep = 0.001; % time integration step, s
dxstep = 0.005;%%0.005; 00;% space integration step, um
t = 0:dtstep:Tend;
x25 = 0:dxstep:L25;
x50 = 0:dxstep:L50;% 10001 points
x100 = 0:dxstep:L100;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%MAJOR
% 
% figure
% set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% 
% plot(x,ORIGINAL(:,2))
% hold on
% plot(x,MONAI(:,2))
% plot(x,ROTH(:,2))
% plot(x,MAJOR(:,2))
% plot(0:0.5:49.5,Vexp)
% plot(0:0.5:49.5,VexpectedExp)
% xlim([0 50])
% set(gcf,'pos',[0 0 1000 600])
% ylabel('Maximum Voltage [mV]')
% xlabel('Distance along ER [\mum]')
% title('Maximum Voltage in ER (r=25nm) for different parameter sets')
% legend('Set 1','Set 2','Set 3','Set 4','Experimental Voltage','Predicted from Caffeine')
% %legend('5nm','10nm','25nm','35nm','Experimental Voltage','Predicted from Caffeine')
% 
% %legend('5nm, Rm 1e12, Ri 1e6','10nm, Rm 1e12, Ri 1e6','25nm, Rm 1e12, Ri 1e6','30nm, Rm 1e12, Ri 1e6');
% % legend('5nm, Rm low, Ri high','5nm, Rm low, Ri low','5nm, Rm low, Ri high','5nm, Rm high, Ri high',.../
% %     '10nm, Rm low, Ri high','10nm, Rm low, Ri low','10nm, Rm low, Ri high','10nm, Rm high, Ri high',.../
% %     '25nm, Rm low, Ri high','25nm, Rm low, Ri low','25nm, Rm low, Ri high','25nm, Rm high, Ri high',.../
% %     '30nm, Rm low, Ri high','30nm, Rm low, Ri low','30nm, Rm low, Ri high','30nm, Rm high, Ri high');
% %legend('5nm','10nm','25nm','35nm','50nm');
% set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% %pngfile = fullfile(pathname, 'Voltage-maxVoltageVsX-BaseModelandExp.png');
% pngfile = fullfile(pathname, 'Voltage-maxVoltageVsX-ModelandExp-25nm-allPARASETS.png');
% saveas(gcf, pngfile);
% epsfile = fullfile(pathname, 'Voltage-maxVoltageVsX-ModelandExp-25nm-allPARASETS.eps');
% saveas(gcf, epsfile);
% 
% %same as above but for 20nm
% figure
% set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% 
% plot(x,ORIGINAL(:,1))
% hold on
% plot(x,MONAI(:,1))
% plot(x,ROTH(:,1))
% plot(x,MAJOR(:,1))
% plot(0:0.5:49.5,Vexp)
% plot(0:0.5:49.5,VexpectedExp)
% xlim([0 50])
% set(gcf,'pos',[0 0 1000 600])
% ylabel('Maximum Voltage [mV]')
% xlabel('Distance along ER [\mum]')
% title('Maximum Voltage in ER (r=20nm) for different parameter sets')
% legend('Set 1','Set 2','Set 3','Set 4','Experimental Voltage','Predicted from Caffeine')
% %legend('5nm','10nm','25nm','35nm','Experimental Voltage','Predicted from Caffeine')
% 
% %legend('5nm, Rm 1e12, Ri 1e6','10nm, Rm 1e12, Ri 1e6','25nm, Rm 1e12, Ri 1e6','30nm, Rm 1e12, Ri 1e6');
% % legend('5nm, Rm low, Ri high','5nm, Rm low, Ri low','5nm, Rm low, Ri high','5nm, Rm high, Ri high',.../
% %     '10nm, Rm low, Ri high','10nm, Rm low, Ri low','10nm, Rm low, Ri high','10nm, Rm high, Ri high',.../
% %     '25nm, Rm low, Ri high','25nm, Rm low, Ri low','25nm, Rm low, Ri high','25nm, Rm high, Ri high',.../
% %     '30nm, Rm low, Ri high','30nm, Rm low, Ri low','30nm, Rm low, Ri high','30nm, Rm high, Ri high');
% %legend('5nm','10nm','25nm','35nm','50nm');
% set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% %pngfile = fullfile(pathname, 'Voltage-maxVoltageVsX-BaseModelandExp.png');
% pngfile = fullfile(pathname, 'Voltage-maxVoltageVsX-ModelandExp-20nm-allPARASETS.png');
% saveas(gcf, pngfile);
% epsfile = fullfile(pathname, 'Voltage-maxVoltageVsX-ModelandExp-20nm-allPARASETS.eps');
% saveas(gcf, epsfile);
% 
% %same as above but for 30nm
% figure
% set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% 
% plot(x,ORIGINAL(:,3))
% hold on
% plot(x,MONAI(:,3))
% plot(x,ROTH(:,3))
% plot(x,MAJOR(:,3))
% plot(0:0.5:49.5,Vexp)
% plot(0:0.5:49.5,VexpectedExp)
% xlim([0 50])
% set(gcf,'pos',[0 0 1000 600])
% ylabel('Maximum Voltage [mV]')
% xlabel('Distance along ER [\mum]')
% title('Maximum Voltage in ER (r=30nm) for different parameter sets')
% legend('Set 1','Set 2','Set 3','Set 4','Experimental Voltage','Predicted from Caffeine')
% %legend('5nm','10nm','25nm','35nm','Experimental Voltage','Predicted from Caffeine')
% 
% %legend('5nm, Rm 1e12, Ri 1e6','10nm, Rm 1e12, Ri 1e6','25nm, Rm 1e12, Ri 1e6','30nm, Rm 1e12, Ri 1e6');
% % legend('5nm, Rm low, Ri high','5nm, Rm low, Ri low','5nm, Rm low, Ri high','5nm, Rm high, Ri high',.../
% %     '10nm, Rm low, Ri high','10nm, Rm low, Ri low','10nm, Rm low, Ri high','10nm, Rm high, Ri high',.../
% %     '25nm, Rm low, Ri high','25nm, Rm low, Ri low','25nm, Rm low, Ri high','25nm, Rm high, Ri high',.../
% %     '30nm, Rm low, Ri high','30nm, Rm low, Ri low','30nm, Rm low, Ri high','30nm, Rm high, Ri high');
% %legend('5nm','10nm','25nm','35nm','50nm');
% set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% %pngfile = fullfile(pathname, 'Voltage-maxVoltageVsX-BaseModelandExp.png');
% pngfile = fullfile(pathname, 'Voltage-maxVoltageVsX-ModelandExp-30nm-allPARASETS.png');
% saveas(gcf, pngfile);
% epsfile = fullfile(pathname, 'Voltage-maxVoltageVsX-ModelandExp-30nm-allPARASETS.eps');
% saveas(gcf, epsfile);
% 
% %same as above but for 35nm
% figure
% set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% 
% plot(x,ORIGINAL(:,4))
% hold on
% plot(x,MONAI(:,4))
% plot(x,ROTH(:,4))
% plot(x,MAJOR(:,4))
% plot(0:0.5:49.5,Vexp)
% plot(0:0.5:49.5,VexpectedExp)
% xlim([0 50])
% set(gcf,'pos',[0 0 1000 600])
% ylabel('Maximum Voltage [mV]')
% xlabel('Distance along ER [\mum]')
% title('Maximum Voltage in ER (r=35nm) for different parameter sets')
% legend('Set 1','Set 2','Set 3','Set 4','Experimental Voltage','Predicted from Caffeine')
% %legend('5nm','10nm','25nm','35nm','Experimental Voltage','Predicted from Caffeine')
% 
% %legend('5nm, Rm 1e12, Ri 1e6','10nm, Rm 1e12, Ri 1e6','25nm, Rm 1e12, Ri 1e6','30nm, Rm 1e12, Ri 1e6');
% % legend('5nm, Rm low, Ri high','5nm, Rm low, Ri low','5nm, Rm low, Ri high','5nm, Rm high, Ri high',.../
% %     '10nm, Rm low, Ri high','10nm, Rm low, Ri low','10nm, Rm low, Ri high','10nm, Rm high, Ri high',.../
% %     '25nm, Rm low, Ri high','25nm, Rm low, Ri low','25nm, Rm low, Ri high','25nm, Rm high, Ri high',.../
% %     '30nm, Rm low, Ri high','30nm, Rm low, Ri low','30nm, Rm low, Ri high','30nm, Rm high, Ri high');
% %legend('5nm','10nm','25nm','35nm','50nm');
% set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% %pngfile = fullfile(pathname, 'Voltage-maxVoltageVsX-BaseModelandExp.png');
% pngfile = fullfile(pathname, 'Voltage-maxVoltageVsX-ModelandExp-35nm-allPARASETS.png');
% saveas(gcf, pngfile);
% epsfile = fullfile(pathname, 'Voltage-maxVoltageVsX-ModelandExp-35nm-allPARASETS.eps');
% saveas(gcf, epsfile);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%varying 3 variables for all 3 lengths
aList = [0.020 0.025];%BASE RADIUS IS 25 nm!
RmList = [1e12 1e15];% 1e15];%[1e7*(1e4)^2];
RiList = [1e6 1e8];% 1e10];%[1e6*(1e4)];
%resultmaxesA= zeros(length(x),length(aList),length(RmList),length(RiList));%save the soln and maxes for each variation

%25um
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);
colorcounter=1;
for i = 1:length(aList)
    for j = 1:length(RmList)
        for k = 1:length(RiList)
            plot(x25, ORIGINALVar25(:, i,j,k)/max(ORIGINALVar25(:, i,j,k)),'Color' , colors{colorcounter})
            hold on
            colorcounter = colorcounter+1;
        end
    end
end
plot(0:0.5:49.5,Vexp/max(Vexp),'k')
plot(0:0.5:49.5,VexpectedExp/max(VexpectedExp),'Color' , colors{10})
xlim([0 50])
set(gcf,'pos',[0 0 1000 600])
ylabel('Normalized Maximum Voltage')
xlabel('Distance along ER [\mum]')
title('Maximum Voltage in the ER for different parameters')
legend('20nm, Rm 1e12, Ri 1e6','20nm, Rm 1e12, Ri 1e8','20nm, Rm 1e15, Ri 1e6','20nm, Rm 1e15, Ri 1e8',.../
    '25nm, Rm 1e12, Ri 1e6','25nm, Rm 1e12, Ri 1e8','25nm, Rm 1e15, Ri 1e6','25nm, Rm 1e15, Ri 1e8',.../
    'Experimental Voltage','Predicted from Caffeine');
%legend('5nm','10nm','25nm','35nm','50nm');
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);


%%%%50
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);
colorcounter=1;
for i = 1:length(aList)
    for j = 1:length(RmList)
        for k = 1:length(RiList)
            plot(x50, ORIGINALVar50(:, i,j,k)/max(ORIGINALVar50(:, i,j,k)),'Color' , colors{colorcounter})
            hold on
            colorcounter = colorcounter+1;
        end
    end
end
plot(0:0.5:49.5,Vexp/max(Vexp),'k')
plot(0:0.5:49.5,VexpectedExp/max(VexpectedExp),'Color' , colors{10})
xlim([0 50])
set(gcf,'pos',[0 0 1000 600])
ylabel('Normalized Maximum Voltage')
xlabel('Distance along ER [\mum]')
title('Maximum Voltage in the ER for different parameters')
legend('20nm, Rm 1e12, Ri 1e6','20nm, Rm 1e12, Ri 1e8','20nm, Rm 1e15, Ri 1e6','20nm, Rm 1e15, Ri 1e8',.../
    '25nm, Rm 1e12, Ri 1e6','25nm, Rm 1e12, Ri 1e8','25nm, Rm 1e15, Ri 1e6','25nm, Rm 1e15, Ri 1e8',.../
    'Experimental Voltage','Predicted from Caffeine');
%legend('5nm','10nm','25nm','35nm','50nm');
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);


%100um
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);
colorcounter=1;
for i = 1:length(aList)
    for j = 1:length(RmList)
        for k = 1:length(RiList)
            plot(x100, ORIGINALVar100(:, i,j,k)/max(ORIGINALVar100(:, i,j,k)),'Color' , colors{colorcounter})
            hold on
            colorcounter = colorcounter+1;
        end
    end
end
plot(0:0.5:49.5,Vexp/max(Vexp),'k')
plot(0:0.5:49.5,VexpectedExp/max(VexpectedExp),'Color' , colors{10})
xlim([0 100])
set(gcf,'pos',[0 0 1000 600])
ylabel('Normalized Maximum Voltage')
xlabel('Distance along ER [\mum]')
title('Maximum Voltage in the ER for different parameters')
legend('20nm, Rm 1e12, Ri 1e6','20nm, Rm 1e12, Ri 1e8','20nm, Rm 1e15, Ri 1e6','20nm, Rm 1e15, Ri 1e8',.../
    '25nm, Rm 1e12, Ri 1e6','25nm, Rm 1e12, Ri 1e8','25nm, Rm 1e15, Ri 1e6','25nm, Rm 1e15, Ri 1e8',.../
    'Experimental Voltage','Predicted from Caffeine');
%legend('5nm','10nm','25nm','35nm','50nm');
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%varyingradius for all 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%lengths

aList = [0.020 0.025 0.030 0.035];%BASE RADIUS IS 25 nm!
RmList = [1e12];% 1e15];%[1e7*(1e4)^2];
RiList = [1e6];% 1e10];%[1e6*(1e4)];
%resultmaxesA= zeros(length(x),length(aList),length(RmList),length(RiList));%save the soln and maxes for each variation

%%%%%%%%%%%%%25
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);
colorcounter=1;
for i = 1:length(aList)
    for j = 1:length(RmList)
        for k = 1:length(RiList)
            plot(x25, ORIGINAL25(:, i,j,k)/max(ORIGINAL25(:, i,j,k)),'Color' , colors{colorcounter})
            hold on
            colorcounter = colorcounter+1;
        end
    end
end
plot(0:0.5:49.5,Vexp/max(Vexp),'k')
plot(0:0.5:49.5,VexpectedExp/max(VexpectedExp),'Color' , colors{10})
xlim([0 50])
set(gcf,'pos',[0 0 1000 600])
ylabel('Normalized Maximum Voltage')
xlabel('Distance along ER [\mum]')
title('Maximum Voltage in the ER for different parameters')
%legend('20nm, Rm 1e12, Ri 1e6','20nm, Rm 1e12, Ri 1e8','20nm, Rm 1e15, Ri 1e6','20nm, Rm 1e15, Ri 1e8',.../
%    '25nm, Rm 1e12, Ri 1e6','25nm, Rm 1e12, Ri 1e8','25nm, Rm 1e15, Ri 1e6','25nm, Rm 1e15, Ri 1e8',.../
%    'Experimental Voltage','Predicted from Caffeine');
% legend('5nm','10nm','25nm','35nm','50nm');
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);

% pngfile = fullfile(pathname, 'Voltage-maxVoltageVsX-ModelandExp-varyARmRiControl-normalized.png');
% saveas(gcf, pngfile);
% epsfile = fullfile(pathname, 'Voltage-maxVoltageVsX-ModelandExp-varyARmRiControl-normalized.eps');
% saveas(gcf, epsfile);

%%%%%%%%%%50
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);
colorcounter=1;
for i = 1:length(aList)
    for j = 1:length(RmList)
        for k = 1:length(RiList)
            plot(x50, ORIGINAL50(:, i,j,k)/max(ORIGINAL50(:, i,j,k)),'Color' , colors{colorcounter})
            hold on
            colorcounter = colorcounter+1;
        end
    end
end
plot(0:0.5:49.5,Vexp/max(Vexp),'k')
plot(0:0.5:49.5,VexpectedExp/max(VexpectedExp),'Color' , colors{10})
xlim([0 50])
set(gcf,'pos',[0 0 1000 600])
ylabel('Normalized Maximum Voltage')
xlabel('Distance along ER [\mum]')
title('Maximum Voltage in the ER for different parameters')
%legend('20nm, Rm 1e12, Ri 1e6','20nm, Rm 1e12, Ri 1e8','20nm, Rm 1e15, Ri 1e6','20nm, Rm 1e15, Ri 1e8',.../
%    '25nm, Rm 1e12, Ri 1e6','25nm, Rm 1e12, Ri 1e8','25nm, Rm 1e15, Ri 1e6','25nm, Rm 1e15, Ri 1e8',.../
%    'Experimental Voltage','Predicted from Caffeine');
% legend('5nm','10nm','25nm','35nm','50nm');
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);


%%%%%%%%%%100
figure
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);
colorcounter=1;
for i = 1:length(aList)
    for j = 1:length(RmList)
        for k = 1:length(RiList)
            plot(x100, ORIGINAL100(:, i,j,k)/max(ORIGINAL100(:, i,j,k)),'Color' , colors{colorcounter})
            hold on
            colorcounter = colorcounter+1;
        end
    end
end
plot(0:0.5:49.5,Vexp/max(Vexp),'k')
plot(0:0.5:49.5,VexpectedExp/max(VexpectedExp),'Color' , colors{10})
xlim([0 50])
set(gcf,'pos',[0 0 1000 600])
ylabel('Normalized Maximum Voltage')
xlabel('Distance along ER [\mum]')
title('Maximum Voltage in the ER for different parameters')
%legend('20nm, Rm 1e12, Ri 1e6','20nm, Rm 1e12, Ri 1e8','20nm, Rm 1e15, Ri 1e6','20nm, Rm 1e15, Ri 1e8',.../
%    '25nm, Rm 1e12, Ri 1e6','25nm, Rm 1e12, Ri 1e8','25nm, Rm 1e15, Ri 1e6','25nm, Rm 1e15, Ri 1e8',.../
%    'Experimental Voltage','Predicted from Caffeine');
% legend('5nm','10nm','25nm','35nm','50nm');
set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
set(0,'defaultAxesFontSize', 28)
set(findall(gca, 'Type', 'Line'),'LineWidth',4);




%%%%%%%%%%%%%%%%%%%%%%%%%normalizing radius
% 
% figure
% set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% colorcounter=1;
% for k = 1:4
%     plot(x, ORIGINAL(:,k)/max(ORIGINAL(:,k)),'Color' , colors{colorcounter})
%     hold on
%     colorcounter = colorcounter+1;
% end
% plot(0:0.5:49.5,Vexp/max(Vexp),'k')
% plot(0:0.5:49.5,VexpectedExp/max(VexpectedExp),'Color' , colors{10})
% xlim([0 50])
% set(gcf,'pos',[0 0 1000 600])
% ylabel('Normalized Maximum Voltage')
% xlabel('Distance along ER [\mum]')
% title('Maximum Voltage in the ER for different ER radius')
% legend('20 nm','25 nm','30 nm','35 nm','Experimental Voltage','Predicted from Caffeine')
% set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% %pngfile = fullfile(pathname, 'Voltage-maxVoltageVsX-BaseModelandExp.png');
% pngfile = fullfile(pathname, 'Voltage-maxVoltageVsX-ModelandExp-varyA-CONTROL-normalized.png');
% saveas(gcf, pngfile);
% epsfile = fullfile(pathname, 'Voltage-maxVoltageVsX-ModelandExp-varyA-CONTROL-normalized.eps');
% saveas(gcf, epsfile);
% 
% figure
% set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% colorcounter=1;
% for k = 1:4
%     plot(x, ORIGINAL(:,k),'Color' , colors{colorcounter})
%     hold on
%     colorcounter = colorcounter+1;
% end
% plot(0:0.5:49.5,Vexp,'k')
% plot(0:0.5:49.5,VexpectedExp,'Color' , colors{10})
% xlim([0 50])
% set(gcf,'pos',[0 0 1000 600])
% ylabel('Normalized Maximum Voltage')
% xlabel('Distance along ER [\mum]')
% title('Maximum Voltage in the ER for different ER radius')
% legend('20 nm','25 nm','30 nm','35 nm','Experimental Voltage','Predicted from Caffeine')
% set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% %pngfile = fullfile(pathname, 'Voltage-maxVoltageVsX-BaseModelandExp.png');
% pngfile = fullfile(pathname, 'Voltage-maxVoltageVsX-ModelandExp-varyA-CONTROL.png');
% saveas(gcf, pngfile);
% epsfile = fullfile(pathname, 'Voltage-maxVoltageVsX-ModelandExp-varyA-CONTROL.eps');
% saveas(gcf, epsfile);
% 
% %%%
% %pulling out just the max Voltage vs X for the big para sweep but only at
% %every 0.5 um instead of 0.005 um.
% 
% aList = [0.020 0.025];%BASE RADIUS IS 25 nm!
% RmList = [1e12 1e15];% 1e15];%[1e7*(1e4)^2];
% RiList = [1e6 1e8];% 1e10];%[1e6*(1e4)];
% shortVaryARmRi = zeros(101,length(aList),length(RmList),length(RiList));%save the soln and maxes for each variation
% 
% for i = 1:length(aList)
%     for j = 1:length(RmList)
%         for k = 1:length(RiList)
%             for xindex = 1:101
%                 index = (1+100*(xindex-1));
%                 shortVaryARmRi(xindex,i,j,k) = ORIGINALVar(index, i,j,k);
%             end
%         end
%     end
% end
% 
% figure
% set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);
% colorcounter=1;
% for i = 1:length(aList)
%     for j = 1:length(RmList)
%         for k = 1:length(RiList)
%             plot(0:0.5:50, shortVaryARmRi(:, i,j,k)/max(shortVaryARmRi(:, i,j,k)),'Color' , colors{colorcounter})
%             hold on
%             colorcounter = colorcounter+1;
%         end
%     end
% end
% plot(0:0.5:49.5,Vexp/max(Vexp),'k')
% plot(0:0.5:49.5,VexpectedExp/max(VexpectedExp),'Color' , colors{10})
% xlim([0 50])
% set(gcf,'pos',[0 0 1000 600])
% ylabel('Normalized Maximum Voltage')
% xlabel('Distance along ER [\mum]')
% title('Maximum Voltage in the ER for different parameters')
% legend('20nm, Rm 1e12, Ri 1e6','20nm, Rm 1e12, Ri 1e8','20nm, Rm 1e15, Ri 1e6','20nm, Rm 1e15, Ri 1e8',.../
%     '25nm, Rm 1e12, Ri 1e6','25nm, Rm 1e12, Ri 1e8','25nm, Rm 1e15, Ri 1e6','25nm, Rm 1e15, Ri 1e8',.../
%     'Experimental Voltage','Predicted from Caffeine');
% set(findall(gcf,'type','text'),'FontSize',28,'fontWeight','bold')
% set(0,'defaultAxesFontSize', 28)
% set(findall(gca, 'Type', 'Line'),'LineWidth',4);