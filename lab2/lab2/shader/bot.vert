#version 330 core

// Input
layout(location = 0) in vec3 vertexPosition;
layout(location = 1) in vec3 vertexNormal;
layout(location = 2) in vec2 vertexUV;
layout(location = 3) in vec4 vertexJoint; //joints
layout(location = 4) in vec4 vertexWeight; //weight


// Output data, to be interpolated for each fragment
out vec3 worldPosition;
out vec3 worldNormal;
out vec2 fragUV; //do we need fragUV??

uniform mat4 MVP;
uniform mat4 u_jointMatrix[25];
uniform mat4 model;

void main() {
    vec4 normalizedWeights = vertexWeight / dot(vertexWeight, vec4(1.0));

    //skinning transformation
    mat4 skinMatrix =
    vertexWeight.x * u_jointMatrix[int(vertexJoint.x)] +
    vertexWeight.y * u_jointMatrix[int(vertexJoint.y)] +
    vertexWeight.z * u_jointMatrix[int(vertexJoint.z)] +
    vertexWeight.w * u_jointMatrix[int(vertexJoint.w)];

    vec4 skinnedPosition = skinMatrix * vec4(vertexPosition, 1.0);

    gl_Position =  MVP * skinnedPosition ;

    vec3 skinnedNormal = mat3(skinMatrix) * vertexNormal;

    worldPosition = vec3(skinMatrix * vec4(vertexPosition, 1.0));
    worldNormal = normalize(mat3(inverse(skinMatrix)) * vertexNormal);

}
