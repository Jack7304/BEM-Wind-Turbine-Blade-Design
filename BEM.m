% BEM code to produce maximum power for a given blade radius
% 02/07/2022 Author: Robert Humphries & Julien Dupin
% all units are meters/seconds/kilograms
% the aerofoil to be used is the S809.

clear;
clc;
format long % expresses numbers in terms of decimals rather than fractions

% -----------------------------------------------------------------------
 %%%%% Variables definition table %%%%%

% Radius ------- Total Radius of blade
% Wind_Speed_Stall -------------- wind speed at which the turbine stalls
% Rho_air ------------- density of air
% TSR ---------- Tip Speed Ratio
% Blade_no ---------- number of blades
% N ----------- number of blade elements to iterate over
% C_l ------------ coefficient of lift of aerofoil profile
% Section_Length ---------- the length of 1 section of blade
% Omega ------------- angular velocity of blade
% indstart -------------- optimal induction factor
% AvSolidity ------------ average solidity. !!!! Unsure wether we need to
%                         define a local solidity
% ind_new --------------- new induction factor
% thetacurrent ----------- input for the inner for loop of the nested loop

 
% -----------------------------------------------------------------------
% Input Values

Radius = 0.25;  % Max radius of blade
Wind_Speed_Stall = 10; % Stall wind speed
Rho_air = 1.225; % air density
TSR = 5; % optimal TSR from paper (YARA, CHANGE)
Blade_no = 3; % number of blades. Can manually change to see if 5 is actually better. Noise might be worse/better
N = 10; % number of blade elements to iterate over
indstart = 0.33;
% Chord_average=Radius/10; % !!!!! temporary dummy value, it should be the local chord length that matters
% + Local_Chord=(16*pi*Radius^2)/(9*Blade_no*C_l*r*TSR^2)
%Aerofoil = xlsread('S809_Aerofoil'); % our Aerofoil profile
C_l = 1; % coefficient of lift from Yaras paper
Alpha=8; % angle of attack from Yaras paper, not sure we need this

 
% -----------------------------------------------------------------------
% data calculated from input data
Section_Length=Radius/N; % radius section length as a step
Omega=(TSR*Wind_Speed_Stall)/Radius;
% AvSolidity=Blade_no*Chord_average/(2*pi*Radius); % to be replaced with the local solidity within the nested loop when how is found out.
% Local_Solidity=AvSolidity; % dummy variable temporarily added in
% + Local_Solidity=(Blade_no*Local_Chord)/(Radius*2) % Turbine diameter is 2 * Radius

% -----------------------------------------------------------------------

% Creating empty arrays to store data for each BEM blade section
BlSp=[]; % Local Blade Span (m)
BlCrvAC=repelem(0,N); % Local Blade Curvature AC [out-of-plane/thurst] offset (m) --- Set to 0
BlSwpAC=repelem(0,N); % Local Blade Sweep AC [in-plane/tangential] offset (m) =') --- Set to 0
BlCrvAng=repelem(0.0,N); % Local Blade Curvature Angle (deg) --- Set to 0
BlTwist=[]; % Local Blade Twist (radians)
BlTwistDegrees=[];
BlChord=[]; % Local Blade Chord (m)
BlChordRatio=[];
Faxial=[];
MomentArr=[];
BlAFID=repelem(1,N); % Local Blade AFID (-) --- Set to 1

 % -----------------------------------------------------------------------

% BEM Loop Code (core code)
thetamax=pi/2; % [Angle in radians]

rstart=0;
for r = rstart:Section_Length:Radius
    %disp(' ')
    %disp('r =')
    %disp(r)
    Local_TSR=Omega*r/Wind_Speed_Stall; % Or: Local_TSR = TSR * r/Radius
    thetastart = atan((1-indstart)/Local_TSR); % Local_TSR causes this result to be 90 degrees [Angle in radians]
    Local_Chord=(16*pi*r^2)/(9*Blade_no*C_l*r*Local_TSR^2); % Or: Local_Chord=(16*pi*r)/(9*Blade_no*C_l*Local_TSR^2)
    Chord_to_R_ratio = Local_Chord/Radius;
    Local_Solidity=(Blade_no*Local_Chord)/(r*2); % Turbine diameter is 2 * Radius
    for thetacurrent = thetastart:0.1:thetamax % [Angle in radians]
        F=(Local_Solidity*C_l)/(4*sin(thetacurrent)*tan(thetacurrent)); % [Angle in radians]
        ind_new=F/(1+F);
        thetafuture = atan((1-ind_new)/Local_TSR); % [Angle in radians]
        if (thetafuture - thetacurrent) < 0.05 % On the next line (before break) results need to be stored in array (Julien job). Also input the imperical chord thickness equation here.
            NrRad = round(N*r/Radius);
            BlSp(NrRad) = r;
            %BlTwist(NrRad) = thetafuture*pi/180; % [Angle in radians]
            BlTwistDegrees(NrRad)=thetafuture*180/pi;
            BlChord(NrRad) = Local_Chord;
            BlChordRatio(NrRad) = Chord_to_R_ratio;
            %disp(' ')
            Vr = sqrt(((Omega*r)^2)+((Wind_Speed_Stall*(1-ind_new))^2));
            Faxial(NrRad) = (1/2)*(Vr^2)*Rho_air*Local_Chord*C_l*cosd(Alpha);
            MomentArr(NrRad) = Faxial(NrRad).*r;
            % I think theres a problem with Faxial. Its currently
            % calculating r as the distance from hub to r in each instant,
            % not the actual section length. Thats what is wrong, 
            break
        end
        thetafuture = thetacurrent;
    end
end



 
% -----------------------------------------------------------------------
% === DISPLAYING BLADE PARAMETERS UNDER ASHES FORMATTING ===

% Displaying ASHES headings under correct and reproducable formatting
%disp('Number of blade nodes: ')
%disp(N)
%disp('BlSp          BlCrvAC         BlSwpAC         BlCrvAng            BlTwist         BlChord         BlAFID          BlRelThick          BlPAD')
%disp('(m)            (m)         (m)         (deg)            (deg)         (m)         (-)          (-)          (-)')
% Displaying  Blade Design Parameters under correct ASHES formatting
%for row = 1:1:N
    %disp('row =')
    %disp(row)
    %disp('Local Blade Span (m) =')
    %disp(BlSp(1,row)) % disp('          ')
    %disp('Local Blade Curvature AC [out-of-plane/thurst] offset (m) =')
    %disp(BlCrvAC(1,row)) % disp('          ')
    %disp('Local Blade Sweep AC [in-plane/tangential] offset (m) =')
    %disp(BlSwpAC(1,row)) % disp('          ')
    %disp('Local Blade Curvature Angle (deg) =')
    %disp(BlCrvAng(1,row)) % disp('          ')
    %disp('Local Blade Twist (deg) =')
    %disp(BlTwist(1,row)) % disp('          ')
    %disp('Local Blade Chord (m) =')
    %disp(BlChord(1,row)) % disp('          ')
    %disp('Local Blade AFID (-) =')
    %disp(BlAFID(1,row)) % disp('          ')
    %disp(' ')
    %disp(' ')
%end

% -----------------------------------------------------------------------

% sum outputs 
 SumofFaxial=sum(Faxial); % this is the sum of axial force. (sheer force). Not entirely sure if its correct.
 SumofMoments=sum(MomentArr);

