import { IsDate, IsEmpty, IsNotEmpty, IsNumber, IsOptional } from "class-validator";
import { User } from "src/auth/schemas/user.schema";
import { Medicine } from "src/medicine/schemas/medicine.schema";

export class UpdateOrderDto {
    @IsNotEmpty()
    readonly medicineId: Medicine;

    @IsOptional()
    readonly quantity: String;

    @IsOptional()
    readonly date: String;

    @IsNotEmpty()
    readonly userId: User
}