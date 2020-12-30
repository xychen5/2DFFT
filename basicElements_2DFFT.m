% for f(x, y) = 1 in 2D FFT: 
% we draw some of the basic elements in 2D FFT

% suppose this is a square iamge
img_size = 100;
x_step = 1;     
y_step = 1;
basic_elements = zeros(img_size, img_size);
all_img = zeros(img_size, img_size, 64);
all = [];
tmp_raw = [];
j = 1i;
% all = zeros(img_size*8, img_size*8);
for u = 1:8
    for v = 1:8
        for x = x_step:x_step:x_step*img_size
            for y=y_step:y_step:y_step*img_size
                basic_elements(x/x_step, y/y_step)=cos((u-1)*2*pi*x/img_size + (v-1)*2*pi*y/img_size);
                %+ j * sin((u-1)*2*pi*x/img_size + (v-1)*2*pi*y/img_size);
            end
        end
        all_img(:, :, (u-1)*8 + v) = basic_elements;
    end
end

% cat 88
for u = 1:8
   all = vertcat( ...   
        horzcat(...
            all_img(:, :, (8-u)*8 + 1), ...
            all_img(:, :, (8-u)*8 + 2), ...
            all_img(:, :, (8-u)*8 + 3), ...
            all_img(:, :, (8-u)*8 + 4), ...
            all_img(:, :, (8-u)*8 + 5), ...
            all_img(:, :, (8-u)*8 + 6), ...
            all_img(:, :, (8-u)*8 + 7), ...
            all_img(:, :, (8-u)*8 + 8)  ...
        ), ...
        all...
    ); 
end

figure(4);
subplot(1,2,1)
imshow(all)
hold on
[xt, yt] = meshgrid(round(linspace(1, size(all, 1), 9)), ...
round(linspace(1, size(all, 2), 9)));%生成数据点矩阵
mesh(yt, xt, zeros(size(xt)), 'FaceColor', ...
'None', 'LineWidth', 1, ...
'EdgeColor', 'r');%绘制三维网格图
axis on
set(gca,'XTick',yt(:,1))
set(gca,'YTick',xt(1,:))
xlabel('Y')
ylabel('X')
title('some basic elements of 2D FFT')
% hold on;
subplot(1,2,2)
[xt, yt] = meshgrid(round(linspace(1, size(all, 1), 9)), ...
round(linspace(1, size(all, 2), 9)));%生成数据点矩阵
mesh(yt, xt, ones(size(xt)), 'FaceColor', ...
'None', 'LineWidth', 1, ...
'EdgeColor', 'r');%绘制三维网格图
axis on
set(gca,'XTick',yt(:,1))
set(gca,'YTick',xt(1,:))
xlabel('V * 100')
ylabel('U * 100')
title('some basic elements in plane wave of 2D FFT')
hold on;
mesh(all)
pbaspect([10 10 2])