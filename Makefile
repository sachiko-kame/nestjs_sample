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
	@echo '次の処理始める前に何回か確認します。確認作業は各最高40回ほどおこないます。'
	@echo '確認開始(mysqlログイン正常に行うための確認)　/var/run/mysqld/mysqld.sockの確認。(時間たつと出来るもののため)'
	@for i in {1..40}; \
		do sleep 1; \
		mysql99_sock=`docker exec -i -t mysql99 bash -c 'ls /var/run/mysqld/mysqld.sock' | cut -c 24-27 | sed 's/ //g'`; \
    	if [ $$mysql99_sock == 'sock' ]; then \
    	  echo '確認出来ましたので抜けます。'$$i'/40 回目'; \
		  break; \
    	else \
    	  echo '確認出来ませんでした。'$$i'/40 回目'; \
    	fi; \
	done 
	@echo '確認作業終了(◍•ᴗ•◍) ※この時点で40/40 回目の表示がある場合上手く言っていません。make db_check, make db_start 実行お願いします。'

db_start:
	@echo '現在DB構築開始(◍•ᴗ•◍)'
	@for i in {1..40}; \
		do sleep 1; \
		mysql99_init=`docker exec -i -t mysql99 bash -c 'mysql -u root -pexample sample_db < ./docker-entrypoint-initdb.d/*.sql' | cut -c 1-10 | sed -e 's/ //g'`; \
		mysql99_init=`echo $$mysql99_init | sed -e 's/ //g'`; \
		if [ $$mysql99_init != 'mysql:[WaERROR1045' ]; then \
		  echo '問題なく入りました。'$$i'/40 回目'; \
		  break; \
		else \
		  echo '上手くいきませんでした(最大40回繰り返します)。'$$i'/40 回目'; \
    	fi; \
	done 
	@echo 'DB構築終了(◍•ᴗ•◍) ※この時点で40/40 回目の表示がある場合上手く言っていません。make db_start やり直しお願いします。'

app_reset:
	# app_stop と　app_rm　該当するものない時は上手くいきません。その時はその部分コメントアウトで使ってください
	make app_stop
	make app_rm
	make app_prune

app_prune:
	docker system prune --volumes
	docker image prune

app_stop:
	# 参考:https://www.k-hitorigoto.online/entry/2022/09/05/080000
	app99_CONTAINER_ID=`docker ps --filter name=app99 --format "{{.ID}}" | cut -c 1-12`; \
	adminer99_CONTAINER_ID=`docker ps --filter name=adminer99 --format "{{.ID}}"`; \
	mysql99_CONTAINER_ID=`docker ps --filter name=mysql99 --format "{{.ID}}"`; \
	docker stop $$app99_CONTAINER_ID $$adminer99_CONTAINER_ID $$mysql99_CONTAINER_ID;

app_rm:
	# 参考:https://www.k-hitorigoto.online/entry/2022/09/05/080000
	app99_CONTAINER_ID=`docker ps -a --filter name=app99 --format "{{.ID}}" | cut -c 1-12`; \
	adminer99_CONTAINER_ID=`docker ps -a --filter name=adminer99 --format "{{.ID}}"`; \
	mysql99_CONTAINER_ID=`docker ps -a --filter name=mysql99 --format "{{.ID}}"`; \
	docker rm $$app99_CONTAINER_ID $$adminer99_CONTAINER_ID $$mysql99_CONTAINER_ID;