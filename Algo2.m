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

global l;
l = 0;

global M;
keySet = [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23];
valueSet = {[-1 0] [0 -1] [0 1] [1 0] [-1 -1] [-1 1] [1 -1] [1 1] [-2 0] [0 -2] [0 2] [2 0] [-2 -1] [-2 1] [-1 -2] [-1 2] [1 -2] [1 2] [2 -1] [2 1] [-2 -2] [-2 2] [2 -2] [2 2]};
M = containers.Map(keySet,valueSet);

    for i = 1:n
        for j = 1:n
            if J(i,j) == 0 || J(i,j) == 255
                J(i,j) = NewValue(i,j);
            end
        end
    end
    
subplot(1,3,3
imshow(J)
[peaksnr, snr] = psnr(I,J)

function nv = NewValue(x,y)
    global J;
    global l;
    global M;
    if l == 2
        l = 6;
    else
        v = M(l);
        while true
            if x+v(1) < 1 || x+v(1) > 512 || y+v(2) < 1 || y+v(2) > 512
                 l = mod(l+1,24);
                 v = M(l);
                 continue; 
            elseif J(x+v(1),y+v(2)) == 0 || J(x+v(1),y+v(2)) == 255
                 l = mod(l+1,24);
                 v = M(l);
                 continue;
            else
                break;
            end
        end
    end
    v = M(l);
    nv = J(x+v(1),y+v(2));
end

