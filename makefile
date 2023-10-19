build:
	docker-compose build
build-no-cache:	
	docker-compose build --no-cache
up:
	docker-compose up
down: 
	docker-compose down
web: 
	docker-compose exec frontend sh
api:
	docker-compose exec backend bash
db: 
	docker-compose exec db bash

