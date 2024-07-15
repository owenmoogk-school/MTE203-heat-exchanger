% Parameters for Case 1 (in meters)
L = 3000/1000; % Length of the elliptic cylinder in mm
a = 400/1000; % Semi-major axis of the ellipse in mm
b = 200/1000; % Semi-minor axis of the ellipse in mm
w = 100/1000; % Width of the tube in mm
d = 50/1000; % Depth of the tube in mm

% Plot the elliptic cylinder (shell)
theta = linspace(0, 2*pi, 100);
z = linspace(0, L, 100);
[Theta, Z] = meshgrid(theta, z);
X_shell = a * cos(Theta);
Z_shell = b * sin(Theta);
Y_shell = Z;

figure;
surf(X_shell, Y_shell, Z_shell, 'EdgeColor', 'none');
hold on;

% Plot the six tubes inside the shell
% Define the vertices of the rectangular prism
tube_x = [-a, a, a, -a, -a, a, a, -a];
tube_y = [-w/2, -w/2, w/2, w/2, -w/2, -w/2, w/2, w/2];
tube_z = [-d/2, -d/2, -d/2, -d/2, d/2, d/2, d/2, d/2];

% Define the faces of the rectangular prism
faces = [
    1 2 6 5; % Bottom face
    2 3 7 6; % Side face
    3 4 8 7; % Top face
    4 1 5 8; % Side face
    1 2 3 4; % Front face
    5 6 7 8; % Back face
];
for i = 0:5
    shift_y = i * (L / 6) + L/12 ;
    
    % Shift the vertices
    x = tube_x;
    y = tube_y + shift_y;
    z = tube_z;
    
    % Plot the faces
    for j = 1:size(faces, 1)
        fill3(x(faces(j, :)), y(faces(j, :)), z(faces(j, :)), 'r', 'FaceAlpha', 0.5);
    end
    
    % Plot the edges
    for j = 1:size(faces, 1)
        for k = 1:size(faces, 2)
            next_k = mod(k, size(faces, 2)) + 1;
            plot3([x(faces(j, k)) x(faces(j, next_k))], [y(faces(j, k)) y(faces(j, next_k))], [z(faces(j, k)) z(faces(j, next_k))], 'r', 'LineWidth', 2);
        end
    end
end
title('Elliptic Cylinder and Tubes');
xlabel('X');
ylabel('Y');
zlabel('Z');
axis equal;
grid on;
hold off;

% Define the density functions
shell_density = @(x, y, z) ones(size(x));
tube_density = @(x, y, z) ones(size(x));

% Shell Volume
z_min = @(x,y) -sqrt(1 - x.^2/a^2) * b;
z_max = @(x,y) sqrt(1 - x.^2/a^2) * b;
shell_volume = integral3(shell_density, -a, a, 0, L, z_min, z_max);

% Tube Volume
tube_volume = integral3(tube_density, 0, w, 0, d, -a, a);

% Cap Volume
x_min = @(y,z) sqrt(1-z.^2/b^2) * a;
capFun = @(y,z,x) ones(size(y));
cap_volume = integral3(capFun, 0, w, -d/2, d/2, x_min, a);

% Total volume of oil required
total_volume = shell_volume - 6 * tube_volume + 12 * cap_volume;

% Display results
fprintf('Volume of the shell: %.5f m^3\n', shell_volume);
fprintf('Volume of one tube: %.5f m^3\n', tube_volume);
fprintf('Volume of one cap: %.5f m^3\n', cap_volume);
fprintf('Total volume of oil required: %.5f m^3\n', total_volume);



