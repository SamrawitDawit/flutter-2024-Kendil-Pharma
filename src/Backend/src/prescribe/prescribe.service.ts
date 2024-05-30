import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import mongoose, { Model } from 'mongoose';
import { Prescribe } from './schema/prescribe.schema';
import { UpdatePrescribeDto } from './dto/update-prescribe.dto';

@Injectable()
export class PrescriptionService {
  constructor(
    @InjectModel(Prescribe.name)
    private prescriptionModel: mongoose.Model<Prescribe>,
  ) {}

  async createPrescription(prescribe:Prescribe): Promise<Prescribe>  {
    const createdPrescription = await this.prescriptionModel.create(prescribe);
    return createdPrescription;
  }

  async getPrescriptionsByUserId(userId: string): Promise<Prescribe[]> {
    return await this.prescriptionModel.find({ userId }).exec();
  }

  async updatePrescription(userId: string, prescriptionId: string, updatedPrescription: UpdatePrescribeDto): Promise<Prescribe> {
    return await this.prescriptionModel.findByIdAndUpdate({ userId, _id: prescriptionId }, updatedPrescription, { new: true });
  }

  async deletePrescription(userId: string, prescriptionId: string): Promise<void> {
    await this.prescriptionModel.deleteOne({ userId, _id: prescriptionId }).exec();
  }  
}
