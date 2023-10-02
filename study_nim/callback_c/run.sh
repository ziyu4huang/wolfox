gcc -c mylib.c -o mylib.o
ar rcs libmylib.a mylib.o
nim c main.nim

./main
