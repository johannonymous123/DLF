function H = linearInterpolationMatrix(x,  y)
    % Check if the input vectors have the same length
    % if length(x) ~= length(u)
    %     error('Vectors x and u must have the same length.');
    % end

    % Initialize the interpolation matrix H
    H = zeros(length(y), length(x));

    for i = 1:length(y)
        % Find the two closest points in x to the point y(i)
        [~, idx1] = min(mod(abs(x - y(i)), numel(x)));
        idx2 = mod(idx1, numel(x)) + 1;

        % Perform linear interpolation with periodic boundaries
        dx1 = mod(x(idx2) - y(i), numel(x));
        dx2 = mod(y(i) - x(idx1), numel(x));
        H(i, idx1) = dx1 / (dx1 + dx2);
        H(i, idx2) = dx2 / (dx1 + dx2);
    end
end
