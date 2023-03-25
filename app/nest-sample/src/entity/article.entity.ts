import { Entity, Column, PrimaryGeneratedColumn } from "typeorm"

@Entity()
export class Article {
    @PrimaryGeneratedColumn()
    id: number

    @Column({
      length: 191,
    })
    user_name: string

    @Column({
      length: 191,
    })
    title: string

    @Column({
      length: 191,
    })
    short_message: string

    @Column("text")
    text: string

    @Column({ 
      type: 'datetime',
      default: () => 'NOW()', 
    })
    created: string

    @Column({ 
      type: 'datetime',
      default: () => 'NOW()', 
    })
    modified: string
}