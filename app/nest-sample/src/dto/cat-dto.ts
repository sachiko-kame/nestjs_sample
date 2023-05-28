import { IsString, IsNotEmpty, IsDefined, IsInt, IsPositive, MaxLength, IsNumberString, IsArray, maxLength } from 'class-validator';
import { Transform, Type } from 'class-transformer';

export class CatDto {
    
    @IsString()
    @IsNotEmpty()
    @MaxLength(10)
    @IsDefined()
    name: string;

    @Type(() => Number)
    @IsInt()
    @IsPositive()
    age: string;

    breed: string;

    // @IsArray()
    // a: string[];
  }