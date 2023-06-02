% Total browsing time in seconds
totalTime = 60 * 60;

% Minimum and maximum browsing time per website in seconds
minTime = 2;
maxTime = 5 * 60;

% Rate parameter for the exponential distribution
lambda = 1 / 30;

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

% Calculate the total number of counts and the total time spent
totalCounts = length(browsingTimes);
totalTimeSpent = sum(browsingTimes) - browsingTimes(end);

% Draw a histogram of the browsing times with 30 bins
figure;
subplot(2, 1, 1);
histogram(browsingTimes, 30, 'Normalization', 'pdf');
xlabel('Time (s)');
ylabel('Frequency');

% Draw a bar plot of the browsing times
subplot(2,1,2);
bar(unique(browsingTimes), histcounts(browsingTimes, [unique(browsingTimes) maxTime + 1]));
xlabel('Time (s)');
ylabel('Count');

% Add the results to the bottom of the figure
str = sprintf('Total number of websites visited: %d\nDuration: %d seconds', totalCounts, totalTimeSpent);
annotation('textbox', [0.46, 0.32, 0.8, 0.1], 'String', str, 'FitBoxToText', 'on');

% Function to draw from a truncated exponential distribution
function x = truncatedExponentialRandom(lambda, min, max)
x = exprnd(1/lambda);
while x < min || x > max
  x = exprnd(1/lambda);
end
end
