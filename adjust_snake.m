function adjusted = adjust_snake(matrix, intensities)
[f,c] = size(matrix);
adjusted = zeros(f,c);
for i=1:f
    adjusted(i,:) = intensities.*matrix(i,:);
end
end