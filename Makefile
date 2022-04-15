all: ray.png sun.ss

ray: ray.sc
	time stalin -On -copt -O2 $<

ray.chicken: ray.c
	gcc -O2 -o $@ $^ -lchicken

ray.c: ray.scm
	chicken $^

ray.scm: chicken.scm utility.scheme surface.scheme ray.scheme
	cat $^ > $@

ray.ss: plt.ss utility.scheme surface.scheme ray.scheme
	cat $^ > $@

ray.sc: stalin.sc utility.scheme surface.scheme ray.scheme
	(cat stalin.sc; cat utility.scheme surface.scheme ray.scheme | tr '[]' '()') > $@

ray.pgm: ray
	time ./$< > $@

ray.png: ray.pgm
	convert -contrast-stretch 0x95% $< $@

sun.ss: plt.ss utility.scheme surface.scheme sun.scheme
	cat $^ > $@
