#include <stddef.h>
#include <stdio.h>

#include <GLFW/glfw3.h>

int main(void) {
    // glfwInit();

    // GLFWwindow* window = glfwCreateWindow(640, 480, "My Title", NULL, NULL);
    // printf("%ld\n", sizeof(window));

    // glfwTerminate();
    printf("%ld\n", sizeof(float));
    printf("%ld\n", sizeof(double));

    double d = 0.12309489873923849;
    printf("%.100lf\n", d);
    printf("%.100f\n", d);

    return 0;
}