local-db:
	docker run --name postgres -e POSTGRES_DB=scrapper -e POSTGRES_USER=vapor -e POSTGRES_PASSWORD=password -p 5432:5432 -d postgres