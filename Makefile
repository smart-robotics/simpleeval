SHELL=/bin/bash

autotest:
	find . -name \*.py -not -path .\/.v\* | entr make test

clean:
	rm -rf build && true
	rm -rf dist && true 
	rm -rf venv && true
	rm -f file.txt && true

test:
	python test_simpleeval.py

test-dev: venv
	source venv/bin/activate && nosetests --stop --pdb test_simpleeval.py

.PHONY: autotest clean test test-dev

venv/:
	python3 -m venv ./venv
	ls ./venv/bin/activate
	source venv/bin/activate && pip install --upgrade pip setuptools wheel && pip install -r requirements-dev.txt

dist/: setup.py simpleeval.py README.rst
	python setup.py build sdist
	twine check dist/*

pypi: test dist/
	twine check dist/*
	twine upload dist/*

