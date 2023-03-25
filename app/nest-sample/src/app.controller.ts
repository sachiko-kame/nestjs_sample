import { Controller, Get, Query } from '@nestjs/common';
import { AppService } from './app.service';
import { Article } from './entity/article.entity';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  getHello(): string {
    return this.appService.getHello();
  }

  @Get('name')
  find(@Query("name") name): Promise<Article[]> {
    console.log(name);
    return this.appService.findAll();
  }

  @Get('sample')
  findOne(@Query("name") name): Promise<Article[]> {
    console.log(name);
    return this.appService.find(name);
  }

  @Get('sample_bad')
  findOneBad(@Query("name") name): Promise<Article[]> {
    console.log(name);
    return this.appService.badFind(name);
  }

  @Get('sample_bad_like')
  findOneBadLike(@Query("name") name): Promise<Article[]> {
    console.log(name);
    return this.appService.badFindLike(name);
  }
}
