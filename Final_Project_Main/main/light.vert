#version 330 core

// Input
layout(location = 0) in vec3 vertexPosition;
layout(location = 1) in vec3 vertexColor;
layout(location = 2) in vec3 vertexNormal;
layout(location = 3) in vec2 vertexUV;

// Output data, to be interpolated for each fragment
out vec3 color;
out vec3 worldPosition;
out vec3 worldNormal;

out vec2 uv;

// Uniforms
uniform mat4 MVP;            // Model-View-Projection matrix
uniform mat4 modelMatrix;    // Model matrix
uniform mat4 normalMatrix;   // Normal matrix (inverse transpose of modelMatrix)

void main() {
    // Transform vertex position
    gl_Position = MVP * vec4(vertexPosition, 1.0);

    // Pass vertex color and UV
    color = vertexColor;
    uv = vertexUV;

    // World-space position
    worldPosition = vec3(modelMatrix * vec4(vertexPosition, 1.0));

    // Transform normal to world space
    worldNormal = mat3(normalMatrix) * vertexNormal;
}
