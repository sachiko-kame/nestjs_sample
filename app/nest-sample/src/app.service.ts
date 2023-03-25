import { Injectable, Inject } from '@nestjs/common';
import { Article } from './entity/article.entity';
import { Repository } from 'typeorm';


@Injectable()
export class AppService {
  constructor(
    @Inject('ARTICLE_REPOSITORY')
    private articleRepository: Repository<Article>,
  ) {}

  getHello(): string {
    return 'Hello World!';
  }

  async findAll(): Promise<Article[]> {
    return await this.articleRepository.find();
  }

  async find(name: string): Promise<Article[]> {
    let selet = `SELECT * FROM article
    WHERE title = ?;`;

    //『''』で囲まれ代入されるよう。
    let param = [name];

    return await this.articleRepository.query(selet, param);
  }

  async badFind(name: string): Promise<Article[]> {
    //全件取得出来てしまう。 => ' or '1' = '1

    let selet = `SELECT * FROM article
    WHERE title = '${name}';`;

    return await this.articleRepository.query(selet);
  }

  async badFindLike(name: string): Promise<Article[]> {
    //全件取得出来てしまう。 => a'  or '1' or '1

    //意図した挙動になるが、、。
    let a = `%${name}%`;
    let selet = `SELECT * FROM article
    WHERE title LIKE '${a}';`;

    return await this.articleRepository.query(selet);

    //意図した挙動になりこっちの方が良い。paramの箇所に%も入れるのかと思った。
    // let a = `%${name}%`;
    // let selet = `SELECT * FROM article
    // WHERE title LIKE ?;`;
    // let param = [a];

    // return await this.articleRepository.query(selet, param);
  }

}