#version 330 core

in vec3 color;
in vec3 worldPosition;
in vec3 worldNormal;

out vec3 finalColor;

uniform vec3 lightPosition;
uniform vec3 lightIntensity;
uniform float exposure;

uniform vec3 ambientLightColor; // Color of the ambient light
uniform float ambientIntensity; // Strength of the ambient light

const float GAMMA = 2.2;

void main()
{
	// Ambient light calculation
	vec3 ambient = ambientLightColor * ambientIntensity;

	// Diffuse lighting calculation
	vec3 N = normalize(worldNormal);
	vec3 L = normalize(lightPosition - worldPosition);
	float diffuseTerm = max(dot(N, L), 0.0);
	float distanceSquared = max(dot(lightPosition - worldPosition, lightPosition - worldPosition), 0.0001);

	float rho_d = 0.5; // Diffuse reflectance
	vec3 diffuse = color * (rho_d / 3.14159265358979) * diffuseTerm * (lightIntensity / (4.0 * 3.14159265358979 * distanceSquared));

	// Combine ambient and diffuse lighting
	vec3 linearColor = ambient + diffuse;

	// Tone mapping (Reinhard operator)
	vec3 toneMapped = linearColor / (vec3(1.0) + linearColor);

	// Gamma correction
	finalColor = pow(toneMapped * exposure, vec3(1.0 / GAMMA));
}

