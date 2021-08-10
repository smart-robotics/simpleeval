SHELL=/bin/bash

autotest:
	find . -name \*.py -not -path .\/.v\* | entr make test

build: venv setup.py simpleeval.py README.rst
	git describe --tags > VERSION
	source venv/bin/activate && python setup.py build sdist && twine check dist/*

clean:
	rm -rf build && true
	rm -rf dist && true 
	rm -f file.txt && true

clean-venv:
	rm -rf venv && true

test:
	python test_simpleeval.py

test-dev: venv
	source venv/bin/activate && nosetests --stop --pdb test_simpleeval.py

.PHONY: autotest build clean test test-dev

venv/:
	python3 -m venv ./venv
	ls ./venv/bin/activate
	source venv/bin/activate && pip install --upgrade pip setuptools wheel && pip install -r requirements-dev.txt

pypi: venv test dist/
	source venv/bin/activate && twine check dist/* && twine upload dist/*

