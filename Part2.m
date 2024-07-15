case1 = true;

if (case1)
    L = 3000/1000; % Length of the elliptic cylinder in mm
    a = 400/1000; % Semi-major axis of the ellipse in mm
    b = 200/1000; % Semi-minor axis of the ellipse in mm
    w = 100/1000; % Width of the tube in mm
    d = 50/1000; % Depth of the tube in mm
    gravity = 9.81; % gravitational constant in m/s
else
    L = 2400/1000; % Length of the elliptic cylinder in mm
    a = 600/1000; % Semi-major axis of the ellipse in mm
    b = 400/1000; % Semi-minor axis of the ellipse in mm
    w = 150/1000; % Width of the tube in mm
    d = 75/1000; % Depth of the tube in mm
    gravity = 9.81; % gravitational constant in m/s
end

shell_density = @(theta, r, y) 420+80*(cos(theta-pi/2)+5*sin(theta+5*pi/2)) .*r;

r_max = @(theta) sqrt((cos(theta).^2/a^2 + sin(theta).^2/b^2).^(-1));
shell_mass = integral3(shell_density, 0, 2*pi, 0, r_max, 0, L);

shell_density_x = @(theta, r, y) shell_density(theta, r, y) .* r.*cos(theta);
shell_density_z = @(theta, r, y) shell_density(theta, r, y) .* r.*sin(theta);
moment_x = integral3(shell_density_x, 0, 2*pi, 0, r_max, 0, L);
moment_z = integral3(shell_density_z, 0, 2*pi, 0, r_max, 0, L);


x_center = moment_x / shell_mass;
z_center = moment_z / shell_mass;

torque = shell_mass * gravity * (x_center + (-a));

display(torque);