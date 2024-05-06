import { IsDate, IsEmpty, IsNotEmpty, IsNumber, IsString } from "class-validator";
import { User } from "src/auth/schemas/user.schema";
import { Medicine } from "src/medicine/schemas/medicine.schema";

export class CreateOrderDto { 

    @IsNotEmpty()
    @IsNumber()
    readonly quantity: String;

    @IsNotEmpty()
    readonly order_date: String;

    @IsEmpty()
    readonly user: User

    // @IsEmpty()
    // readonly medicine: Medicine
}