import { Controller, Get, Query, Post, Body } from '@nestjs/common';
import { agent } from 'supertest';
import { AppService } from './app.service';
import { Article } from './entity/article.entity';
import { CatParams } from './params/cat-params'
import { CatDto } from './dto/cat-dto'

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  getHello(): string {
    return this.appService.getHello();
  }

  @Get('name')
  find(
    @Query() params: CatParams, 
  ): Promise<Article[]> {
    console.log(params.name);
    return this.appService.findAll();
  }


  @Post('name')
  find1(
    @Body() createUserDto:  CatDto
  ): Promise<Article[]> {
    // console.log(params.name);
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
