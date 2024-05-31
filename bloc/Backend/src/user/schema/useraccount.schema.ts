import { Schema, Prop, SchemaFactory } from '@nestjs/mongoose';

export type UserDocument = User & Document;

@Schema()
export class User {
  @Prop({ required: true })
  name: string;


  @Prop({ required: true })
  email: string;

  @Prop({ required: true })
  password: string;

  // Other properties...

  // Additional methods or properties can be defined here if needed.
}

export const UserSchema = SchemaFactory.createForClass(User);