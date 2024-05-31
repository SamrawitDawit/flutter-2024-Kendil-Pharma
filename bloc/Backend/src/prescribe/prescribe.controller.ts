import { Controller, Post, Get, Put, Delete, Param, Body } from '@nestjs/common';
import {PrescriptionService } from './prescribe.service';
import { Prescribe } from './schema/prescribe.schema';
import { Headers } from '@nestjs/common';
import { UpdatePrescribeDto } from './dto/update-prescribe.dto';

@Controller('prescriptions')
export class PrescriptionController {
  constructor(private readonly prescriptionService: PrescriptionService) {}

  @Post()
  async createPrescription(
    @Body()
    prescribe,
  ): Promise<Prescribe> {
    return  this.prescriptionService.createPrescription(prescribe);
  }

//   @Get(':id')
//   async getPrescriptionById(@Param('id') id: string): Promise<Prescribe | null> {
//     return await this.prescriptionService.getPrescriptionById(id);
//   }
    @Get('user/:userId')
    async getPrescriptionsByUserId(@Param('userId') userId: string): Promise<Prescribe[]> {
        return await this.prescriptionService.getPrescriptionsByUserId(userId);
     }

    @Put('user/:userId/prescriptions/:prescriptionId')
    async updatePrescription(
        @Param('userId') userId: string,
        @Param('prescriptionId') prescriptionId: string,
        @Body() updatedPrescribe: UpdatePrescribeDto,
    ): Promise<Prescribe> {
         return  this.prescriptionService.updatePrescription(userId, prescriptionId, updatedPrescribe);
    }

//   @Delete(':id')
//   async deletePrescription(@Param('id') id: string): Promise<Prescribe | null> {
//     return await this.prescriptionService.deletePrescription(id);
//   }

    @Delete('user/:userId/prescriptions/:prescriptionId')
    async deletePrescription(
        @Param('userId') userId: string,
        @Param('prescriptionId') prescriptionId: string
    ): Promise<void> {
        return await this.prescriptionService.deletePrescription(userId, prescriptionId);
    }
}
