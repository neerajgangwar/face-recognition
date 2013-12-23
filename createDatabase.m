clear all
clc

% calculate eigenfaces of dataset

% step 1: Form a data matrix

dataMat = [];
k = 1;
avg = zeros(10304, 1);
for i = 1 : 1 : 40
    for j = 1 : 1 : 10
        a = imread(['Faces/s' num2str(i) '/' num2str(j) '.pgm']);
        [l m] = size(a);
        temp = reshape(a, l*m, 1);
        dataMat(:, k) = double(temp);
        avg = avg + double(temp);
        k = k + 1;
    end
end

clear temp
avg = avg/400;

%imshow(mat2gray(reshape(avg, l, m)))   % view average image

% making average of data vectors zero
for i = 1 : 1 : 400
    dataMat(:, i) = dataMat(:, i) - avg;
end

% calculate eigenfaces
covMat = double(dataMat')*double(dataMat);
[S1 D] = eig(covMat);
S = dataMat*S1;

% normalize eigenfaces to unit norm
for i = 1 : 1 : 400
    S(:, i) = S(:, i)/norm(S(:, i));
end

% consider only 200 eigenfaces corresponding to large eigenvalues
S2 = S(:, 201:400);

% calculate face classes
for i = 1 : 1 : 40
    Omega = [];
    omg = zeros(200, 1);
    for j = 1 : 1 : 10
        img = imread(['Faces/s' num2str(i) '/' num2str(j) '.pgm']);
        [l m] = size(img);
        img = reshape(double(img), l*m, 1) - avg;        
        omg = omg + inv(S2'*S2)*S2'*img;
    end
    Omega(:, i) = omg/10;
end
