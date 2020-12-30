% imageName = 'cat.jpg';
 imageName = 'landscape.jpg';
 lpRatio = 0.8;
% lpRatio = 0.6;
% lpRatio = 0.4;
% lpRatio = 0.3;
origin = imread(imageName);

% ʹ����ɢ����Ҷ�任ѹ��

[z, k] = fft_compress(origin, lpRatio);
subplot(2, 2, 1);
% imshow(z);
t2 = fftshift(z);
t3 = log(1 + abs(t2));
imshow(t3, [])
subplot(2, 2, 2); 
fN = strcat('fft', num2str(lpRatio), imageName);
imshow(k), title(['FFT ���� ', fN]);
imwrite(k, fN);

% ʹ����ɢ���ұ任ѹ��

[z, k] = dct_compress(origin, lpRatio);
subplot(2, 2, 3);
% imshow(z);
t1 = fft2(image);
t2 = fftshift(z);
t3 = log(1 + abs(t2));
imshow(t3, [])


subplot(2, 2, 4);
fN = strcat('dct', num2str(lpRatio), imageName);
imshow(k), title(['DCT ���� ', fN]);
imwrite(k, fN);


function [z, k] = dct_compress(image, ratio)

    % ��ԭ JPG ͼƬ��������ɫ�Ϸֱ�����ά��ɢ���ұ任
    z(:,:,1) = dct2(image(:,:,1));
    z(:,:,2) = dct2(image(:,:,2));
    z(:,:,3) = dct2(image(:,:,3));

    % ��ȡͼƬ�ĳߴ��С
    [a, b, ~] = size(image);

    % ��ͨ�˲�
    for i = 1 : a
        for j = 1 : b
            if (i + j > (a+b) * ratio)
                z(i, j, 1) = 0;
                z(i, j, 2) = 0;
                z(i, j, 3) = 0;
            end
        end
    end

    % �Թ���֮��Ľ����������ɫ�Ϸֱ������ж�ά����ɢ���ұ任
    k(:,:,1) = idct2(z(:,:,1));
    k(:,:,2) = idct2(z(:,:,2));
    k(:,:,3) = idct2(z(:,:,3));

    % ����ת����ת��Ϊ 0-255 ��Χ�ڵ���ɫֵ
    k = uint8(k);
end

% fft_compress.m

% ���ã�ʹ����ɢ����Ҷ�任������� JPG ͼƬ image ����ָ�����˲����� ratio ����ѹ��
% ����ֵ�����ص�ͨ�˲�֮���Ƶ�ʷֲ���ѹ��֮���ͼƬ
function [z, k] = fft_compress(image, ratio)

    % ��ԭ JPG ͼƬ��������ɫ�Ϸֱ�����ά��ɢ����Ҷ�任���õ�Ƶ�ʷֲ�
    z(:,:,1) = fft2(image(:,:,1));
    z(:,:,2) = fft2(image(:,:,2));
    z(:,:,3) = fft2(image(:,:,3));

    % ��ȡͼƬ�ĳߴ��С
    [a, b, ~] = size(image);

    % ��ͨ�˲�
    for i = 1 : a
        for j = 1 : b
            if (i + j > (a+b) * ratio)
                z(i, j, 1) = 0;
                z(i, j, 2) = 0;
                z(i, j, 3) = 0;
            end
        end
    end

    % �Թ���֮��Ľ����������ɫ�Ϸֱ������ж�ά����ɢ����Ҷ�任
    k(:,:,1) = ifft2(z(:,:,1));
    k(:,:,2) = ifft2(z(:,:,2));
    k(:,:,3) = ifft2(z(:,:,3));

    % ����ת����ת��Ϊ 0-255 ��Χ�ڵ���ɫֵ
    k = uint8(k);
end

