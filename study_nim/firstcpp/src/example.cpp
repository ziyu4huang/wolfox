// example.cpp
#include <vector>
#include <iostream>

extern "C" {
    void callFromNim() {
        std::vector<int> vec = {1, 2, 3, 4, 5};
        for (int x : vec) {
            std::cout << x << " ";
        }
        std::cout << std::endl;
    }
}
