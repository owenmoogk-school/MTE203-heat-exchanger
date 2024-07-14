L = 3000;
a = 400;
b = 200;
w = 100;
d = 50;

% Define the range for x and z
theta = linspace(0, 2*pi, 100); % Parameter for the ellipse
y = linspace(0,L, 100); % Range for y

% Create the meshgrid for theta and y
[Theta, Y] = meshgrid(theta, y);

% Calculate X and Z coordinates of the ellipse
X = a * cos(Theta);
Z = b * sin(Theta);

% Plot the surface of the elliptical cylinder
figure;
surf(X, Y, Z, 'FaceAlpha', 0.5, 'EdgeColor', 'none');
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
title('3D Plot of the Elliptical Cylinder \frac{z^2}{b^2} + \frac{x^2}{a^2} = 1');
grid on;
axis equal;
hold on;

% Define vertices for the rotated rectangular prism
vertices = [
    0, -d/2, -w/2;
    0, -d/2, w/2;
    0, d/2, w/2;
    0, d/2, -w/2;
    L, -d/2, -w/2;
    L, -d/2, w/2;
    L, d/2, w/2;
    L, d/2, -w/2;
];

% Define faces for the rectangular prism
faces = [
    1, 2, 6, 5;
    2, 3, 7, 6;
    3, 4, 8, 7;
    4, 1, 5, 8;
    1, 2, 3, 4;
    5, 6, 7, 8;
];

% Plot the rotated rectangular prism
patch('Vertices', vertices, 'Faces', faces, 'FaceColor', 'blue', 'FaceAlpha', 0.3);

% Adjust view and appearance
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
title('3D Plot of Elliptical Cylinder with Rotated Rectangular Prism');
axis equal;
view(3);
hold off;
