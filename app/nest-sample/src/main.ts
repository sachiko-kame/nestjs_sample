import { NestFactory} from '@nestjs/core';
import { AppModule} from './app.module';
import { ValidationPipe } from '@nestjs/common';
import "reflect-metadata";

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  app.useGlobalPipes(new ValidationPipe({
    disableErrorMessages: false, //詳細エラーを無効にするか。
    // whitelist: false, //定義しているパラメーター飲みしか受け付けない
    transform: true, //型指定されたオブジェクトに自動的に変換するもの
  }));
  await app.listen(3000);
}
bootstrap();
