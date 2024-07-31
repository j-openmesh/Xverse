.PHONY: default clean bootstrap

default: clean bootstrap

clean:
	@rm -rf out

out:
	@mkdir out

out/bin: out
	@mkdir out/bin

out/bin/xvs: out/bin
	@cp src/bin/xvs.sh out/bin/xvs
	@chmod +x out/bin/xvs

bootstrap: out/bin/xvs
