import { Injectable } from '@nestjs/common';
import {NotFoundException} from '@nestjs/common'
import { InjectModel } from '@nestjs/mongoose';
import * as  mongoose from 'mongoose';
import { Medicine } from './schemas/medicine.schema';
import { CreateMedicineDto } from './dto/create.medicine.dto';
import multer from 'multer';
import {Request} from 'express';
/* import { save } from './schemas/medicine.schema' */

@Injectable()
export class MedicineService {
    constructor(
        @InjectModel(Medicine.name)
        private medicineModel: mongoose.Model<Medicine>
    ){}

    async findAll():Promise<Medicine[]>{
        const medicine = await this.medicineModel.find()
        return medicine
    }

    // async create(createMedicineDto: CreateMedicineDto, imageFile: Express.Multer.File): Promise<Medicine> {
    //     const { title, detail, usedfor, price, category } = createMedicineDto;
    
    //     const medicine = new this.medicineModel({
    //       title,
    //       detail,
    //       usedfor,
    //       price,
    //       category,
    //       image: imageFile.path, // Assuming the file path is available in the Multer file object
    //     });
    
    //     return medicine.save();
    //   }

    async create(medicine: Medicine): Promise<Medicine>{
        const res = await this.medicineModel.create(medicine)
        return res
    }

    async findById(id: string): Promise<Medicine> {
        console.log('Finding medicine with ID:', id); // Log the ID
    
        // Ensure the ID is a valid ObjectId
        if (!id.match(/^[0-9a-fA-F]{24}$/)) {
          throw new NotFoundException('Invalid ID format');
        }
    
        const medicine = await this.medicineModel.findById(id).exec();
        
        if (!medicine) {
          console.log('Medicine not found'); // Log if medicine is not found
          throw new NotFoundException('Medicine not found');
        }
    
        console.log('Medicine found:', medicine); // Log the found medicine
        return medicine;
      }


     async updateById(id:string, medicine: Medicine)/* Promise<Medicine> */{
        return await this.medicineModel.findByIdAndUpdate({_id:id}, medicine,{
            new:true,
            runVailators: true,  
    })
    } 

    async deleteById(id:string): Promise<Medicine>{
        return await this.medicineModel.findByIdAndDelete({_id:id},{
            new:true
        });
    }
}
