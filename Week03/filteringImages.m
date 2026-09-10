%% Deconvolution in x-space
% clc;clear;close all;

img = dicomread('pigdicom/1.3.12.2.1107.5.2.31.30831.2013040319074561753595406.dcm');

figure(2)
subplot(1,2,1)
imshow(img, [min(img(:)), max(img(:))]);
Inoise = im2double(img) +  0.0.*(rand(size(img))*2 - 1) ;%000000001;
subplot(1,2,2)
imshow(Inoise, [min(Inoise(:)), max(Inoise(:))]);

%%
% h1 = fspecial('gaussian',10);  % this is the smoothing kernel     
% img =  conv2(Inoise,h1);
img = Inoise; 

% figure(3)
% subplot(1,2,1)
% imshow(Inoise, [min(Inoise(:)), max(Inoise(:))]);
% subplot(1,2,2)
% imshow(img, [min(img(:)), max(img(:))]);

%% Convolution itself is a linear operator that can be represented as A (convolution kernal) * x (original image) =b (blurred image)
img = imresize(img, [128,128]);  

h = ones(3,3)
n = size(img,1); m = size(img,2);
N = size(h,1); M = size(h,2);

p = phantom(n+1-N,m+1-M); %for test 

[A,~,convedP] = getConvMat(h,p);  % Fill in the blanks in the getConvMat function in getConvMat_A7.m

%A = sparse(A);  %Convert the convolution transformation matrix, into a sparse matrix (You may skip this step!)

% I = reshape(img,n,m);

figure(1)
subplot(2,2,1),imshow(p,[min(min(p)) max(max(p))]),title('original img')
subplot(2,2,2),imagesc(h),title('PSF')
subplot(2,2,3), imshow(convedP, [min(min(convedP)) max(max(convedP))]), title('blurred img')


%% Convolution with internal matlab functions

% Assuming img is your image matrix and h is your kernel matrix

% Convert image to double for precision
img = double(img);

h = ones(7,7);
% Perform convolution using the conv2 function
% 'same' returns the central part of the convolution, same size as img
convolved_img = conv2(img, h, 'same');

% Display the original and convolved images
figure;
subplot(1, 2, 1);
imshow(img,[min(img(:)), max(img(:))]); % Convert back to uint8 for display
title('Original Image');

subplot(1, 2, 2);
imshow(convolved_img,[min(convolved_img(:)), max(convolved_img(:))]); % Convert back to uint8 for display
title('Convolved Image');




%% Deconvolution in image domain (with deconvolution) 
figure(1);  
subplot(2,2,3)
imshow(img,[min(min(img)) max(max(img))]); 
title('Blurred image, J, - no noise'); 

DeblurredImage = A\img(:);
subplot(2,2,4)
imshow(reshape(DeblurredImage,n,m), [min(DeblurredImage) max(DeblurredImage) ]);
title('De-Blurred image, I, based on A\J'); 


%% Lets try deblurring using the idea of the Fourier equivalent of convolution:   
clc
figure(2)
imgK = fftshift(fft2(img));
% hK = fftshift(fft2(imresize(h, size(img))));
hK = fftshift(fft2(h, size(img,1), size(img,2) ));

deblurredImageK = imgK./hK;
deblurredImageK_reconstruct = ifft2(fftshift(deblurredImageK));
imagesc(deblurredImageK_reconstruct)