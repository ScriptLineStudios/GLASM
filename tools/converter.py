text = """
#version 330 core
layout(location=0) in vec2 aPos;
layout(location=1) in vec2 aUv;

out vec2 uv;

void main() {
    gl_Position = vec4(aPos.xy, 0.0, 1.0); 
    uv = aUv;
}
"""

text2 = """
#version 330 core
in vec2 uv;
uniform sampler2D image;

void main() {
    gl_FragColor = texture(image, uv);
}
"""

for word in text:
    print(hex(ord(word)), end=", ")
print(0)
