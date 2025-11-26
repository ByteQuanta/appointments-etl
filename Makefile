.PHONY: build up logs down clean

build:
	docker-compose build --no-cache

up:
	docker-compose up --remove-orphans

logs:
	docker-compose logs -f

down:
	docker-compose down

clean:
	docker-compose down -v --remove-orphans
	docker image rm appointments-etl || true
