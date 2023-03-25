start:
	@echo '環境構築中…(◍•ᴗ•◍) ※この後あまりにも処理動くまで時間かかる場合Dockerがそもそも動いていない可能性あるので確認してください'
	chmod -R 777 ./db/mysql/logs
	make app_build
	make db_check
	make db_start
	make app_start
	@echo '環境構築終了(◍•ᴗ•◍)'

app_build:
	docker-compose up --build -d

app_start:
	docker exec -i -t app99 bash -c 'cd ./nest-sample && npm run start:dev'

db_check:
	@echo '次の処理始める前に何回か確認します。確認作業は最高30かいほどおこないます。'
	@for i in {1..30}; \
		do sleep 1; \
		mysql99_sock=`docker exec -i -t mysql99 bash -c 'ls /var/run/mysqld/mysqld.sock' | grep sock | cut -c 1-22 | sed 's/ //g'`; \
    	if [ $$mysql99_sock == '/var/run/mysqld/mysqld' ]; then \
    	  echo '確認出来ましたので抜けます。'$$i'/30 回目'; \
		  break; \
    	else \
    	  echo '確認出来ませんでした。'$$i'/30 回目'; \
    	fi; \
	done 
	@echo 'おわり'

db_start:
	@echo '現在DB構築開始(◍•ᴗ•◍)'
	docker exec -i -t mysql99 bash -c 'mysql -u root -pexample sample_db < ./docker-entrypoint-initdb.d/*.sql'
	@echo 'DB構築終了(◍•ᴗ•◍)'