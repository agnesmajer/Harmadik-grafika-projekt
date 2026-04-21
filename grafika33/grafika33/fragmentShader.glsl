#version 330 core
out vec4 FragColor;

in vec3 FragPos;
in vec3 Normal;
in vec2 TexCoords;

uniform vec3 lightPos;
uniform vec3 lightColor;
uniform vec3 objectColor;
uniform bool useLighting;
uniform bool useTexture;
uniform sampler2D screenTexture;

void main() {
    if(!useLighting) {
        FragColor = vec4(objectColor, 1.0);
        return;
    }
    // Ambient
    float ambientStrength = 0.2;
    vec3 ambient = ambientStrength * lightColor;
    // Diffuse 
    vec3 norm = normalize(Normal);
    vec3 lightDir = normalize(lightPos - FragPos);
    float diff = max(dot(norm, lightDir), 0.0);
    vec3 diffuse = diff * lightColor;
    
    vec3 result = (ambient + diffuse) * objectColor;
    if(useTexture) {
        FragColor = texture(screenTexture, TexCoords) * vec4(result, 1.0);
    } else {
        FragColor = vec4(result, 1.0);
    }
}
