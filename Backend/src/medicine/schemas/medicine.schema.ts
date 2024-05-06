import { Prop, Schema, SchemaFactory} from "@nestjs/mongoose";
import { Document, Types } from "mongoose";


export enum Category {
    PAINKILLER = 'Painkiller',
    ANTIBIOTICS = 'Antibiotics'
}
@Schema({
    timestamps:true,
})

export class Medicine{
    /* [x: string]: any; */
    /* save() {
        throw new Error('Method not implemented.');
    } */
    // @Prop({ type: Types.ObjectId })
    // _id: Types.ObjectId;

    @Prop()    
    title: string;
    @Prop()
    detail: string;

    @Prop() 
    price: String;
    
    @Prop()  
    category: Category;
}
export const MedicineSchema = SchemaFactory.createForClass(Medicine)