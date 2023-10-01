// mylib.c
#include <stdio.h>

typedef void (*CallbackType)(int);

void call_with_five(CallbackType callback) {
  callback(5);
}


