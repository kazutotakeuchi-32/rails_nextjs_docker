build:
	docker-compose build
build-no-cache:	
	docker-compose build --no-cache
up:
	docker-compose up
down: 
	docker-compose down
web: 
	docker-compose exec web sh
api:
	docker-compose exec api bash
ap:
	docker-compose exec ap sh
db: 
	docker-compose exec db bash
