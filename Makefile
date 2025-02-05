all: # Run everything
all: setup test lint clean

setup: # Setup dependencies
setup: 
	@pip install -r requirements.txt

test: # Run tests with pytest and coverage
test: 
	coverage run -m pytest

lint: # Check with mypy, pyflakes, black
lint: 
	python -m pyflakes lexicalrichness/lexicalrichness.py
	python -m pyflakes tests/test_lexicalrichness.py

clean: # Purge caches and output files
clean:	
	@rm -rf __pycache__
	@rm -rf .pytest_cache
	@rm -rf .mypy_cache
	@rm -rf .coverage

prepack: # Prepare packaging for PyPi
prepack:
	@rm -rf dist/ runpynb.egg-info/
	python setup.py sdist
	twine check dist/*

PACKAGE_FILES := build/ dist/ *.egg-info/ *.egg
cleanpack: # Remove distribution/packaging files
cleanpack:
	@rm -rf $(PACKAGE_FILES)

.DEFAULT_GOAL := help

help: # Show Help
	@egrep -h '\s#\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?# "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
