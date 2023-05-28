import { IsString, IsNotEmpty, IsDefined, IsInt, IsPositive, MaxLength, IsNumberString } from 'class-validator';
import { Transform, Type } from 'class-transformer';

export class CatParams {
    
    @IsString()
    @IsNotEmpty()
    @MaxLength(10)
    @IsDefined()
    name: string;

    @Type(() => Number)
    @IsInt()
    @IsPositive()
    age: string;

    // @IsNumberString()
    // @Transform(value => Number(value))
    // @Transform(age => Number(age), {toClassOnly: true})
    // @IsInt()
    // @IsPositive()
    // @IsNumberString()
    // @Type(() => String)
    // @IsNumberString()
    age2:number;

    breed: string;
  }