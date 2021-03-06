uniform mat4 uMVPMatrix;

attribute vec4 vPosition;
attribute vec3 normal;
attribute vec2 texCoord;

uniform mat4 worldMat;
uniform mat3 tpInvWorldMat;
uniform vec3 eyePos, lightPosL, lightPosR;
uniform vec3 lightAttL, lightAttR;

varying vec3 v_normal;
varying vec2 v_texCoord;
varying vec3 v_view, v_lightL, v_lightR;
varying float v_attL, v_attR;

void main() {
    // world-space position
    vec3 worldPos = (worldMat * vPosition).xyz;

    //-------------------------------------------------------
    // Problem 3
    // Implement the phong shader using 2 color point lights.

    // world-space vertex normal
    v_normal = normalize(tpInvWorldMat * normal);

    // view vector
    v_view = normalize(eyePos - worldPos);

    // light vectors
    v_lightL = normalize(lightPosL - worldPos);
    v_lightR = normalize(lightPosR - worldPos);

    // attenuations
    float distL = length(lightPosL - worldPos);
    float distR = length(lightPosR - worldPos);
    v_attL = 1.0 / (lightAttL.x + lightAttL.y * distL + lightAttL.z * distL*distL);
    v_attR = 1.0 / (lightAttR.x + lightAttR.y * distR + lightAttR.z * distR*distR);

    //-------------------------------------------------------

    // texture coordinates
    v_texCoord = texCoord;

    // clip-space position
    gl_Position = uMVPMatrix * vec4(worldPos, 1.0);
}