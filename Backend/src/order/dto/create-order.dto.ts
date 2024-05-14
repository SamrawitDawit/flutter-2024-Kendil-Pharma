import { IsDate, IsEmpty, IsNotEmpty, IsNumber, IsString } from "class-validator";
import { User } from "src/auth/schemas/user.schema";
import { Medicine } from "src/medicine/schemas/medicine.schema";

export class CreateOrderDto { 
    @IsNotEmpty()
    readonly medicineId: Medicine;

    @IsNotEmpty()
    readonly quantity: String;

    @IsNotEmpty()
    readonly date: String;

    @IsEmpty()
    readonly userId: User

}