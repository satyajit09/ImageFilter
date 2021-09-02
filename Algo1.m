clc
clear all
struct = load("lena512.mat");
I = uint8(struct.lena512);
subplot(1,3,2)
imshow(I)
n = size(I);
global J
J = imnoise(I,'salt & pepper',0.2);
K = J;
subplot(1,3,1)
imshow(J)

for k = 1:3
    for i = 1:n
        for j = 1:n
            if J(i,j) == 0 || J(i,j) == 255
                J(i,j) = NewValue(i,j);
            end
        end 
    end 
end
subplot(1,3,3)
imshow(J)
[peaksnr, snr] = psnr(I,J)
function nv = NewValue(x,y)
    B = [];
    global J
    for i = x-1:x+1
        for j = y-1:y+1
            if i > 0 && j > 0 && i <= 512 && j <= 512 
                if J(i,j) ~= 0 && J(i,j) ~= 255
                    B = [B J(i,j)]; %#ok<AGROW>
                end
            end   
        end
    end
    if isempty(B)
        nv = J(x,y);
    else
        nv = mean(B);
    end
end

