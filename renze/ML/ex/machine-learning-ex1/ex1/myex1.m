clear ; close all; clc


data = load('ex1data2.txt');

X = data(:,1:2); y = data(:,3);


#plot(X,y,'rx','MarkerSize', 10);

m = length(y);
X = [ones(m, 1), X];
theta = normalEqn(X,y);

#hold on
#plot(X(:,2), X*theta, "-");

fprintf("%f %f \n", theta(1), theta(2));
