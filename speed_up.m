% May 2025 SM Lambrick
%
% This file calculates the speed up in image aquisition of the B-SHeM 3D
% reconstructions over the A-SHeM ones.

% Bad...
clear;clc;

addpath('datafiles')

%% A SHeM
% 5 scans taken on the A-SHeM
data_ind = [3248, 3250, 3259, 3260, 3262];
ASHeM_t_min = 0;
for i_=1:length(data_ind)
    load(['/MATLAB Drive/3D_data/scan00' num2str(data_ind(i_)) '.mat'])
    convertToHoursAndMinutes(meas_list{1}.scan_time/60);
    disp(['Dwell time per pixel: ' num2str(extract_ashem_dwell(meas_list{1})) 'ms'])
    % Add them up because they take different amounts of time each
    ASHeM_t_min = ASHeM_t_min + meas_list{1}.scan_time/60;
end
disp(' ')
disp('A SHeM')
disp(['Dwell time per pixel: ' num2str(extract_bshem_dwell(meas_list{1})) 'ms'])
convertToHoursAndMinutes(ASHeM_t_min);
disp('Average per image:')
convertToHoursAndMinutes(ASHeM_t_min/5);
ASHeM_npix = length(meas_list{1}.full_target);
% 24% of pixels "lost" here due to alignment
ASHeM_npix = ASHeM_npix*0.76;
ASHeM_t_per_pix = ASHeM_t_min*60/ASHeM_npix;
disp(['Time per pixel: ' num2str(round(ASHeM_t_per_pix, 2)) 's'])

% Dwell time for A-SHeM was different, account for that
av_dwell_ashem = (750*2 + 495*3)/5;
ASHeM_equivalent_dwell_min = ASHeM_npix*(1000 - av_dwell_ashem)/(60*1000) + ASHeM_t_min;
convertToHoursAndMinutes(ASHeM_equivalent_dwell_min);
ASHeM_equivalent_t_per_pix = ASHeM_equivalent_dwell_min*60/ASHeM_npix;

% And account for a different pause time


%% B SHeM
% Salt crystal
load("/MATLAB Drive/3D_data/sc100378.mat")
salt_t_min = meas_list{1}.scan_time/60;
disp(' ')
disp('B SHeM: salt crystal')
disp(['Dwell time per pixel: ' num2str(extract_bshem_dwell(meas_list{1})) 'ms'])
convertToHoursAndMinutes(salt_t_min);
salt_npix = length(meas_list{1}.full_target);
salt_t_per_pix = salt_t_min*60/salt_npix;
disp(['Time per pixel: ' num2str(round(salt_t_per_pix, 2)) 's'])

% Spheres, smaller
load("/MATLAB Drive/3D_data/sc100351.mat")
sphere_t_min = meas_list{1}.scan_time/60;
disp(' ')
disp('B SHeM: small sphere')
disp(['Dwell time per pixel: ' num2str(extract_bshem_dwell(meas_list{1})) 'ms'])
convertToHoursAndMinutes(sphere_t_min);
sphere_npix = length(meas_list{1}.full_target);
sphere_t_per_pix = sphere_t_min*60/sphere_npix;
disp(['Time per pixel: ' num2str(round(sphere_t_per_pix, 2)) 's'])

% Spheres, larger
load("/MATLAB Drive/3D_data/sc100354.mat")
sphere2_t_min = meas_list{1}.scan_time/60;
disp(' ')
disp('B SHeM: large sphere')
disp(['Dwell time per pixel: ' num2str(extract_bshem_dwell(meas_list{1})) 'ms'])
convertToHoursAndMinutes(sphere2_t_min);
sphere2_npix = length(meas_list{1}.full_target);
sphere2_t_per_pix = sphere2_t_min*60/sphere2_npix;
disp(['Time per pixel: ' num2str(round(sphere2_t_per_pix, 2)) 's'])

%% Speed up factor

% Speed up for salt
disp(' ')
salt_speed_up = ASHeM_t_per_pix/salt_t_per_pix;
disp(['Speed up for salt = ' num2str(round(salt_speed_up, 2)) 'x'])

% Speed up for spheres
sphere_speed_up = ASHeM_t_per_pix/sphere_t_per_pix;
disp(['Speed up for small sphere = ' num2str(round(sphere_speed_up, 2)) 'x'])
sphere2_speed_up = ASHeM_t_per_pix/sphere2_t_per_pix;
disp(['Speed up for large sphere = ' num2str(round(sphere2_speed_up, 2)) 'x'])


% Speed up for salt
disp(' ')
disp('Correcting for dwell time')
salt_speed_up = ASHeM_equivalent_t_per_pix/salt_t_per_pix;
disp(['Speed up for salt = ' num2str(round(salt_speed_up, 2)) 'x'])

% Speed up for spheres
sphere_speed_up = ASHeM_equivalent_t_per_pix/sphere_t_per_pix;
disp(['Speed up for small sphere = ' num2str(round(sphere_speed_up, 2)) 'x'])
sphere2_speed_up = ASHeM_equivalent_t_per_pix/sphere2_t_per_pix;
disp(['Speed up for large sphere = ' num2str(round(sphere2_speed_up, 2)) 'x'])


%% Helper functions

function [hours, mins] = convertToHoursAndMinutes(minutes)
    hours = floor(minutes / 60); % Calculate the full hours
    mins = mod(minutes, 60);    % Calculate the remaining minutes
    disp([num2str(hours), ' hours and ', num2str(round(mins)), ' minutes']);
end

function in = extract_bshem_dwell(meas)
    in = 0;
    for i_=1:2:length(meas.inputs)
        if strcmp(meas.inputs{i_}, 'dwell_time')
            in = meas.inputs{i_+1};
        end
    end
end

function in = extract_ashem_dwell(meas)
    in = 0;
    for i_=1:2:length(meas.inputs)
        if strcmp(meas.inputs{i_}, 'N_dwell')
            in = 15*meas.inputs{i_+1};
        end
    end
end
