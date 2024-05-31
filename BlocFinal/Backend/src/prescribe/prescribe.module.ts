import { Module } from '@nestjs/common';
import { PrescriptionController } from './prescribe.controller';
import { PrescriptionService } from './prescribe.service';
import { Mongoose } from 'mongoose';
import { MongooseModule } from '@nestjs/mongoose';
import { PrescriptionSchema } from './schema/prescribe.schema';

@Module({
  imports:[MongooseModule.forFeature([{name:'Prescribe', schema:PrescriptionSchema}])],
  controllers: [PrescriptionController],
  providers: [ PrescriptionService]
})
export class PrescribeModule {}
