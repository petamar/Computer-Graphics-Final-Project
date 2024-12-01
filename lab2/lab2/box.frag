#version 330 core

in vec3 color; // Vertex color
in vec2 uv;    // UV coordinates

uniform sampler2D texturesampler;

out vec3 finalColor;

void main()
{
	vec3 textureColor = texture(texturesampler, uv).rgb;
	finalColor = color * textureColor;
}
