text = """
#version 330 core
layout(location=0) in vec2 aPos;
layout(location=1) in vec3 aCol;

out vec3 color;

void main() {
    gl_Position = vec4(aPos.xy, 0.0, 1.0); 
    color = aCol;
}
"""

text2 = """
#version 330 core
in vec3 color;

void main() {
    gl_FragColor = vec4(color.xyz, 1.0);
}
"""

for word in text2:
    print(hex(ord(word)), end=", ")
print(0)
