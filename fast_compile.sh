#!/bin/bash

# Make for file in *... loops fail on 
shopt -s nullglob

cd code

for file in *.c
do
 filename=$(echo "$file" | tr / _)
 echo gcc $GCCFLAGS -g -c "$file" -o objects/"${filename%.*}".o
 gcc $GCCFLAGS -g -c "$file" -o objects/"${filename%.*}".o
done

for file in *.cpp
do
 filename=$(echo "$file" | tr / _)
 echo g++ $GCCFLAGS -g -c "$file" -o objects/"${filename%.*}".o
 g++ $GCCFLAGS -g -c "$file" -o objects/"${filename%.*}".o
done

ar rvs objects/all.a objects/*.o

cd ..

echo "Compiling main -> bitcoinary"
echo gcc $GCCFLAGS -g -I../BitcoinSpoon/code main.c code/objects/all.a BitcoinSpoon/code/objects/all.a BitcoinSpoon/libraries/objects/all.a -lsqlite3 -lgmp -lstdc++ -o binary
gcc $GCCFLAGS -g -I../BitcoinSpoon/code main.c code/objects/all.a BitcoinSpoon/code/objects/all.a BitcoinSpoon/libraries/objects/all.a -lsqlite3 -lgmp -lstdc++ -o binary
