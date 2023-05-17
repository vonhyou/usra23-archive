% Total browsing time in seconds
totalTime = 60 * 60;

% Minimum and maximum browsing time per website in seconds
minTime = 2;
maxTime = 5 * 60;

% Rate parameter for the exponential distribution, set to average 2 minutes
lambda = 1 / 25;

% Preallocate the browsing times array
maxWebsites = ceil(totalTime / minTime);
browsingTimes = zeros(1, maxWebsites);

% Generate the browsing times
i = 1;
while totalTime > minTime
    x = round(truncatedExponentialRandom(lambda, minTime, maxTime));
    totalTime = totalTime - x;
    browsingTimes(i) = x;
    i = i + 1;
end

% Remove unused elements
browsingTimes(i:end) = [];

% Draw a histogram of the browsing times with 30 bins
figure;
subplot(2, 1, 1);
histogram(browsingTimes, 'Normalization', 'pdf');
xlabel('Time (s)');
ylabel('Frequency');

% Draw a bar plot of the browsing times
subplot(2,1,2);
bar(unique(browsingTimes), histcounts(browsingTimes, [unique(browsingTimes) maxTime + 1]));
xlabel('Time (s)');
ylabel('Count');

% Function to draw from a truncated exponential distribution
function x = truncatedExponentialRandom(lambda, min, max)
x = exprnd(1/lambda);
while x < min || x > max
    x = exprnd(1/lambda);
end
end
