all: answer

answer:
	@perl script/calc.pl

test:
	@prove -lv
