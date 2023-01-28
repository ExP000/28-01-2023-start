install: 
	pip install --upgrade pip &&\
		pip install -r requirements.txt
		
lint:
	pylint --disable=R,C *.py devopslib
	
	
test:
	python -m pytest -vv --cov=hello --cov=devopslib test_*.py


format:
	black *.py devopslib/*.py
	

post-install:
	python -m textblob.download_corpora


deploy:
	#deploy
	aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 561744971673.dkr.ecr.us-east-1.amazonaws.com
	docker build -t devopsstart .
	docker tag devopsstart:latest 779475915189.dkr.ecr.us-east-1.amazonaws.com/devopsstart:latest
	docker push 779475915189.dkr.ecr.us-east-1.amazonaws.com/devopsstart:latest


all: install post-install lint test format deploy