import { Body, Controller, Get, Post , Param, Put, Delete, UseGuards} from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { Roles } from 'src/auth/roles.decorator';
import { Role, User } from 'src/auth/schemas/user.schema';
import {RoleGuard} from 'src/auth/role.guard'
import { UserService } from './user.service';

@Controller('users')
@UseGuards(RoleGuard)
export class UserController {
    constructor(private userService: UserService ){}

    @Get('all')
    async getAllUsers(): Promise<User[]>{
        return this.userService.findAll()
    }

    @Get(':id')
    async getUser(
        @Param('id')
        id: string
    ): Promise<User>{
        return this.userService.findById(id);
    }

    // @Post('new')
    // @Roles(Role.PHARMACIST)
    // async createMedicine(
    //     @Body()
    //     medicine:CreateMedicineDto
    // ): Promise<Medicine>{
    //     return this.medicineService.create(medicine)
    // }



    // @Put(':id')
    // // @Roles(Role.PHARMACIST)
    // async updateUser(
    //     @Param('id')
    //     id: string,
    //     @Body()
    //     user: UpdateMedicineDto,
    //     ):Promise<User>{
    //         return this.userService.updateById(id , user);
    //     }

    @Delete(':id')
    // @Roles(Role.PHARMACIST)
    async deleteUser(
        @Param('id')
        id: string,
    ): Promise<User>{
        return this.userService.deleteById(id)
    }
}
