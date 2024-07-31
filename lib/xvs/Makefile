.PHONY: default clean bootstrap rebootstrap

default: bootstrap

clean:
	rm -rf out

out:
	mkdir out

out/bin: out
	mkdir out/bin

src/bin/xvs: out/bin
	cp src/bin/xvs out/bin/xvs
	chmod +x out/bin/xvs

bootstrap: src/bin/xvs

rebootstrap: clean bootstrap
