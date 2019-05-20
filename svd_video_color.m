sz = size(Traffic);

% resize to smaller resolution & seperate color channels
for i=1:sz(4)
   Red(:,:,i) = imresize(Traffic(:,:,1,i),0.2);
   Green(:,:,i) = imresize(Traffic(:,:,2,i),0.2);
   Blue(:,:,i) = imresize(Traffic(:,:,3,i),0.2);
end

% save a video file using the resized color channels.
Traffic_orig(:,:,1,:) = Red;
Traffic_orig(:,:,2,:) = Green;
Traffic_orig(:,:,3,:) = Blue;

% Convert to data type 'double' for computing the SVD below 
Red_double = double(Red);
Green_double = double(Green);
Blue_double = double(Blue);
sz = size(Red_double);


% vectorize the video channels into size (height * width , Num_Of_Frames)
Red_mat = reshape(Red_double,sz(1)*sz(2),sz(3));
Green_mat = reshape(Green_double,sz(1)*sz(2),sz(3));
Blue_mat = reshape(Blue_double,sz(1)*sz(2),sz(3));

% Get SVD decomposition
[UR,SR,VR] = svd(Red_mat);
[UG,SG,VG] = svd(Green_mat);
[UB,SB,VB] = svd(Blue_mat);

% Get Rank 1 Approximation for each RGB channel
UR1 = UR(:,1);
VR1 = VR(:,1);
SR1 = SR(1);
Red_r1_approx = UR1*SR1*VR1';
Red_r1_approx = reshape(Red_r1_approx,sz(1),sz(2),sz(3));
Red_s2s_r1 = cat(2,Red_double,Red_r1_approx);
Red_residual_r1 = Red_double - Red_r1_approx;
Red_residual_r1 = uint8(Red_residual_r1);
Red_s2s_r1 = cat(2,Red_s2s_r1,Red_residual_r1);
Red_s2s_r1 = uint8(Red_s2s_r1);
Red_r1_approx = uint8(Red_r1_approx);

UB1 = UB(:,1);
VB1 = VB(:,1);
SB1 = SB(1);
Blue_r1_approx = UB1*SB1*VB1';
Blue_r1_approx = reshape(Blue_r1_approx,sz(1),sz(2),sz(3));
Blue_s2s_r1 = cat(2,Blue_double,Blue_r1_approx);
Blue_residual_r1 = Blue_double - Blue_r1_approx;
Blue_residual_r1 = uint8(Blue_residual_r1);
Blue_s2s_r1 = cat(2,Blue_s2s_r1,Blue_residual_r1);
Blue_s2s_r1 = uint8(Blue_s2s_r1);
Blue_r1_approx = uint8(Blue_r1_approx);

UG1 = UG(:,1);
VG1 = VG(:,1);
SG1 = SG(1);
Green_r1_approx = UG1*SG1*VG1';
Green_r1_approx = reshape(Green_r1_approx,sz(1),sz(2),sz(3));
Green_s2s_r1 = cat(2,Green_double,Green_r1_approx);
Green_residual_r1 = Green_double - Green_r1_approx;
Green_residual_r1 = uint8(Green_residual_r1);
Green_s2s_r1 = cat(2,Green_s2s_r1,Green_residual_r1);
Green_s2s_r1 = uint8(Green_s2s_r1);
Green_r1_approx = uint8(Green_r1_approx);


% Get Rank 2 Approximation for each RGB channel
UR2 = UR(:,1:2);
VR2 = VR(:,1:2);
SR2 = diag(SR(1:2));
Red_r2_approx = UR2*SR2*VR2';
Red_r2_approx = reshape(Red_r2_approx,sz(1),sz(2),sz(3));
Red_s2s_r2 = cat(2,Red_double,Red_r2_approx);
Red_residual_r2 = Red_double - Red_r2_approx;
Red_residual_r2 = uint8(Red_residual_r2);
Red_s2s_r2 = cat(2,Red_s2s_r2,Red_residual_r2);
Red_s2s_r2 = uint8(Red_s2s_r2);
Red_r2_approx = uint8(Red_r2_approx);

UB2 = UB(:,1:2);
VB2 = VB(:,1:2);
SB2 = diag(SB(1:2));
Blue_r2_approx = UB2*SB2*VB2';
Blue_r2_approx = reshape(Blue_r2_approx,sz(1),sz(2),sz(3));
Blue_s2s_r2 = cat(2,Blue_double,Blue_r2_approx);
Blue_residual_r2 = Blue_double - Blue_r2_approx;
Blue_residual_r2 = uint8(Blue_residual_r2);
Blue_s2s_r2 = cat(2,Blue_s2s_r2,Blue_residual_r2);
Blue_s2s_r2 = uint8(Blue_s2s_r2);
Blue_r2_approx = uint8(Blue_r2_approx);

UG2 = UG(:,1:2);
VG2 = VG(:,1:2);
SG2 = diag(SG(1:2));
Green_r2_approx = UG2*SR2*VR2';
Green_r2_approx = reshape(Green_r2_approx,sz(1),sz(2),sz(3));
Green_s2s_r2 = cat(2,Green_double,Green_r2_approx);
Green_residual_r2 = Green_double - Green_r2_approx;
Green_residual_r2 = uint8(Green_residual_r2);
Green_s2s_r2 = cat(2,Green_s2s_r2,Green_residual_r2);
Green_s2s_r2 = uint8(Green_s2s_r2);
Green_r2_approx = uint8(Green_r2_approx);


% Concatenate the svd approximations of each channel into one video file
Traffic_approx_r1(:,:,1,:) = Red_r1_approx;
Traffic_approx_r1(:,:,2,:) = Green_r1_approx;
Traffic_approx_r1(:,:,3,:) = Blue_r1_approx;

Traffic_residual_r1(:,:,1,:) = Red_residual_r1;
Traffic_residual_r1(:,:,2,:) = Green_residual_r1;
Traffic_residual_r1(:,:,3,:) = Blue_residual_r1;

Traffic_approx_r2(:,:,1,:) = Red_r2_approx;
Traffic_approx_r2(:,:,2,:) = Green_r2_approx;
Traffic_approx_r2(:,:,3,:) = Blue_r2_approx;

Traffic_residual_r2(:,:,1,:) = Red_residual_r2;
Traffic_residual_r2(:,:,2,:) = Green_residual_r2;
Traffic_residual_r2(:,:,3,:) = Blue_residual_r2;

% concatenate original , approximation, and residual & write a video file,
% one for each rank 
 vidObj = VideoWriter('traffic_r1','MPEG-4');
    open(vidObj);
 
    % Create an animation.
    
    axis tight manual
    set(gca,'nextplot','replacechildren');
 
    for k = 1:size(Traffic_approx_r1,4)
       imshow([Traffic_orig(:,:,:,k),Traffic_approx_r1(:,:,:,k),Traffic_residual_r1(:,:,:,k)]);
       % Write each frame to the file.
       currFrame = getframe(gcf);
       writeVideo(vidObj,currFrame);
    end
  
    % Close the file.
    close(vidObj);

    
 vidObj = VideoWriter('traffic_r2','MPEG-4');
    open(vidObj);
 
    % Create an animation.
    
    axis tight manual
    set(gca,'nextplot','replacechildren');
 
    for k = 1:size(Traffic_approx_r2,4)
       imshow([Traffic_orig(:,:,:,k),Traffic_approx_r2(:,:,:,k),Traffic_residual_r2(:,:,:,k)]);
       % Write each frame to the file.
       currFrame = getframe(gcf);
       writeVideo(vidObj,currFrame);
    end
  
    % Close the file.
    close(vidObj);

