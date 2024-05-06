import { Body, Controller, Get, Post , Param, Put, Delete, UseGuards} from '@nestjs/common';
import { MedicineService } from './medicine.service';
import { Medicine } from './schemas/medicine.schema';
import { CreateMedicineDto } from './dto/create.medicine.dto';
import { UpdateMedicineDto } from './dto/update-medicine.dto';
import { AuthGuard } from '@nestjs/passport';
import { Roles } from 'src/auth/roles.decorator';
import { Role } from 'src/auth/schemas/user.schema';
import {RoleGuard} from 'src/auth/role.guard'

@Controller('medicines')
@UseGuards(RoleGuard)
export class MedicineController {
    constructor(private medicineService: MedicineService){}
        
    @Get('all')
    async getAllMed(): Promise<Medicine[]>{
        return this.medicineService.findAll()
    }

    @Get(':id')
    async getMed(
        @Param('id')
        id: string
    ): Promise<Medicine>{
        return this.medicineService.findById(id);
    }

    @Post('new')
    @Roles(Role.PHARMACIST)
    async createMedicine(
        @Body()
        medicine:CreateMedicineDto
    ): Promise<Medicine>{
        return this.medicineService.create(medicine)
    }


    
    @Put(':id')
    @Roles(Role.PHARMACIST)
    async updateMedicine(
        @Param('id')
        id: string,
        @Body()
        medicine: UpdateMedicineDto,
        ):Promise<Medicine>{
            return this.medicineService.updateById(id , medicine);
        }

    @Delete(':id')
    @Roles(Role.PHARMACIST)
    async deleteMedicine(
        @Param('id')
        id: string,
    ): Promise<Medicine>{
        return this.medicineService.deleteById(id)
    }
}
