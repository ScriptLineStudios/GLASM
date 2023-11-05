#include <stddef.h>
#include <stdio.h>

#include <GLFW/glfw3.h>

int main(void) {
    glfwInit();

    GLFWwindow* window = glfwCreateWindow(640, 480, "My Title", NULL, NULL);
    printf("%ld\n", sizeof(window));

    glfwTerminate();
    
    return 0;
}