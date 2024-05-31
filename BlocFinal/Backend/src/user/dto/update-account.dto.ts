import { IsNotEmpty } from 'class-validator';

export class UpdateAccountDto {
  @IsNotEmpty()
  name: string;

  @IsNotEmpty()
  email: string;

}