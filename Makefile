default: clean setup libfoobar.a

OUT_DIR ?= out
BUILD_DIR=$(OUT_DIR)/build

.PHONY: 

clean:
	rm -fr out/

setup: out out/build out/lib out/bin

out: 
	mkdir -p ${OUT_DIR}
out/build: 
	mkdir -p ${OUT_DIR}/build
out/lib:
	mkdir -p ${OUT_DIR}/lib
out/bin:
	mkdir -p ${OUT_DIR}/bin

run_1: out/bin/app1 .PHONY
	echo ">> Running app1..." && \
	${OUT_DIR}/bin/app1

run_2: out/bin/app2 .PHONY
	echo ">> Running app2..." && \
	${OUT_DIR}/bin/app2

out/bin/app1: setup build/main.o libfoo.a libbar.a
	$(CC) ${BUILD_DIR}/main.o -L${OUT_DIR}/lib/ -lfoo -lbar -o ${OUT_DIR}/bin/app1

out/bin/app2: setup build/main.o libfoo.a libbar.a
	$(CC) ${BUILD_DIR}/main.o -L${OUT_DIR}/lib/ -lfoo -lbar -lfoo -lbar -o ${OUT_DIR}/bin/app2

build/main.o: src/main.c
	$(CC) -c -I include src/main.c -o ${BUILD_DIR}/main.o

libfoo.a: build/foo.o
	ar rcs ${OUT_DIR}/lib/libfoo.a ${BUILD_DIR}/foo.o 

libbar.a: build/bar.o
	ar rcs ${OUT_DIR}/lib/libbar.a ${BUILD_DIR}/bar.o

build/foo.o: src/foo.c
	$(CC) -c -I include src/foo.c -o ${BUILD_DIR}/foo.o

build/bar.o: src/bar.c
	$(CC) -c -I include src/bar.c -o ${BUILD_DIR}/bar.o

