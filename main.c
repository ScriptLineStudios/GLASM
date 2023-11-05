#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>

#include <glad/glad.h>
#include <GLFW/glfw3.h>


#define SHADER(src) "#version 330 core\n" #src

int main(void) {
    const char *vertex_src = SHADER(
        layout (location = 0) in vec2 aPos;
        layout (location = 1) in vec3 aCol;

        out vec3 color;

        void main() {
            gl_Position = vec4(aPos.xy, 0.0, 1.0); 
            color = aCol;
        }
    );

    const char *fragment_src = SHADER(
        in vec3 color;

        void main() {
            gl_FragColor = vec4(color.xyz, 1.0);
        }
    );

    glfwInit();

    GLFWwindow *window = glfwCreateWindow(800, 800, "Hello World", NULL, NULL);
    glfwMakeContextCurrent(window);

    if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress)) {
        printf("Failed to load\n");
    }

    unsigned int vao, vbo;
    glGenVertexArrays(1, &vao);
    glBindVertexArray(vao);

    double vertices[15] = {
       -0.5,  -0.5,      1.0, 0.0, 0.0, 
        0.0,   0.37,      0.0, 1.0, 0.0, 
        0.5,  -0.5,      0.0, 0.0, 1.0
    };

    glGenBuffers(1, &vbo);
    glBindBuffer(34962, vbo);
    glBufferData(34962, 120, vertices, 35044);

    glVertexAttribPointer(0, 2, 5130, 0, 40, 0);
    glEnableVertexAttribArray(0);

    glVertexAttribPointer(1, 3, 5130, 0, 40, 16);
    glEnableVertexAttribArray(1);

    unsigned int vertex_shader, fragment_shader;
    vertex_shader = glCreateShader(35633);
    glShaderSource(vertex_shader, 1, &vertex_src, 0);
    glCompileShader(vertex_shader);

    fragment_shader = glCreateShader(35632);
    glShaderSource(fragment_shader, 1, &fragment_src, 0);
    glCompileShader(fragment_shader);

    unsigned int program;
    program = glCreateProgram();
    glAttachShader(program, vertex_shader);
    glAttachShader(program, fragment_shader);
    glLinkProgram(program);
    glUseProgram(program);

    while (!glfwWindowShouldClose(window)) {
        glClearColor(0.1, 0.1, 0.1, 1.0);
        glClear(GL_COLOR_BUFFER_BIT);
        
        glDrawArrays(4, 0, 3);

        glfwSwapBuffers(window);
        glfwPollEvents();
    }

    return 0;
}