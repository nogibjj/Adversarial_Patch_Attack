install:
	pip install --upgrade pip &&\
		pip install -r requirements.txt
	#force install latest whisper
	pip install --upgrade --no-deps --force-reinstall git+https://github.com/openai/whisper.git

install-tensorflow-conda:
	conda install -c conda-forge cudatoolkit=11.2 cudnn=8.1.0 -y
	export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/
	/home/codespace/venv/bin/pip install -r tf-requirements.txt

test:
	echo add tests here
	#python -m pytest -vv --cov=main --cov=mylib test_*.py

format:	
	black tools/*.py

lint:
	echo add linting here
	#pylint --disable=R,C --ignore-patterns=test_.*?py tools/*.py 

container-lint:
	docker run --rm -i hadolint/hadolint < Dockerfile

checkgpu:
	echo "Checking GPU for PyTorch"
	python utils/verify_pytorch.py
	echo "Checking GPU for Tensorflow"
	python utils/verify_tf.py

refactor: format lint

deploy:
	#deploy goes here
		
all: install lint test format deploy
