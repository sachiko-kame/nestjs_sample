import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { DatabaseModule } from './database.module';
import { articleProviders } from './article.providers';

@Module({
  imports: [DatabaseModule],
  controllers: [AppController],
  providers: [AppService, ...articleProviders],
})
export class AppModule {}
