#define STB_IMAGE_IMPLEMENTATION
#include "external/stb_image.h"

int main() {
    unsigned char *data;
    int w, h, n;
    data = stbi_load("test.png", &w, &h, &n, 0);
    printf("width: %d, height: %d, number of channels: %d\n", w, h, n);
    stbi_image_free(data);
    return 0;
}