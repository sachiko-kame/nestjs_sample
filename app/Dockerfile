FROM node:19

# nodeのバージョン確認　※基本指定指定ればこのコマンド不要
RUN node -v

# nestjsのインストール　バージョン指定の場合は後ろに@9.1.2付与
RUN npm i -g @nestjs/cli

# バージョンの確認とnest問題なく入っているかの確認
RUN nest -v