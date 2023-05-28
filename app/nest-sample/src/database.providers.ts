import { DataSource } from 'typeorm';

export const databaseProviders = [
  {
    provide: 'DATA_SOURCE',
    useFactory: async () => {
      const dataSource = new DataSource({
        type: 'mysql',
        host: '192.168.3.35',
        port: 3399,
        username: 'root',
        password: 'example',
        database: 'sample_db',
        entities: ['dist/**/*.entity.js'],
        // entities: [
        //     __dirname + '/../**/*.entity{.ts,.js}',
        // ],
        synchronize: true,
      });

      return dataSource.initialize();
    },
  },
];