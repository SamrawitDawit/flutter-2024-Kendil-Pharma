import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import mongoose from "mongoose";
import { User } from "src/auth/schemas/user.schema";
import { Medicine } from "src/medicine/schemas/medicine.schema";
@Schema({
    timestamps: true
})
export class Order{

    @Prop()
    quantity: String;
    
    @Prop()
    order_date: String;

    @Prop({type: mongoose.Schema.Types.ObjectId, ref:'User'})
    user: User;

    // @Prop({type: mongoose.Schema.Types.ObjectId, ref:'Medicine'})
    // medicine: Medicine;
}
export const OrderShema = SchemaFactory.createForClass(Order)