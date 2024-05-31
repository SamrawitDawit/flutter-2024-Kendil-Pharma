import { Schema, Prop, SchemaFactory } from '@nestjs/mongoose';
import { Document, SchemaTypes } from 'mongoose';

@Schema({
    timestamps: true
})
export class Prescribe extends Document {
    
  @Prop()
  userId: string;

  @Prop()
  patientName: string;

  @Prop()
  medication: string;

  @Prop()
  dosageInstructions: string;

  @Prop()
  duration: string;
}

export const PrescriptionSchema = SchemaFactory.createForClass(Prescribe);