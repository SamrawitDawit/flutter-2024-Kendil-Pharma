import { IsEnum, IsNotEmpty, IsString } from "class-validator"
import { Category } from "../schemas/medicine.schema"
import { ObjectId, Types } from "mongoose";

export class UpdateMedicineDto{
    // _id: Types.ObjectId;

    @IsNotEmpty()
    @IsString()
    title: string
  
    @IsNotEmpty()
    @IsString()
     detail: string

    @IsNotEmpty()
    price: String
    
    @IsNotEmpty()
    @IsEnum(Category, {message: 'Please Enter correct Category'})
    category: Category
}