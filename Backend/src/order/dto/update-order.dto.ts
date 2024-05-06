import { IsDate, IsEmpty, IsNumber, IsOptional } from "class-validator";
import { User } from "src/auth/schemas/user.schema";
import { Medicine } from "src/medicine/schemas/medicine.schema";

export class UpdateOrderDto {
    @IsOptional()
    @IsNumber()
    readonly quantity: String;

    @IsOptional()
    // @IsDate()
    readonly order_date: String;

    @IsEmpty()
    readonly user: User

    // @IsEmpty()
    // readonly medicine: Medicine
}