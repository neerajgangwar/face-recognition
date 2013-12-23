function result = faceMatching(S, Omega, img, avg, errorThreshold)

% function returns index of face that is closest to img and satisfies
% error threshold criterion.

[l m] = size(img);
a = double(reshape(img, l*m, 1)) - avg;
w = inv(S'*S)*S'*a;

minError = inf;

sizeOfOmega = size(Omega, 2);
result = -1;
g = [];
for i = 1 : 1 : sizeOfOmega
    tempError = norm(w - Omega(:, i));
    g = [g tempError];
    if minError >= tempError
        minError = tempError;
        result = i;
    end
end

if minError > errorThreshold
    result = 'not found';
end
end