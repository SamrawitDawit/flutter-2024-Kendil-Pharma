import { Injectable } from '@nestjs/common';
import {NotFoundException} from '@nestjs/common'
import { InjectModel } from '@nestjs/mongoose';
import * as  mongoose from 'mongoose';
import { User } from 'src/auth/schemas/user.schema';


/* import { save } from './schemas/medicine.schema' */

@Injectable()
export class UserService {
    constructor(
        @InjectModel(User.name)
        private userModel: mongoose.Model<User>
    ){}

    async findAll():Promise<User[]>{
        const user = await this.userModel.find()
        return user
    }

    async create(user: User): Promise<User>{
        const res = await this.userModel.create(user)
        return res
    }

    async findById(id:string): Promise<User>{
        const mongoose = require('mongoose');
        const { ObjectId } = require('mongodb');

        const objectId = new ObjectId(id);
        const user = await this.userModel.findById(objectId)


        if(!user){
            throw new NotFoundException('User not found')
        }
        return user
    }
     async updateById(id:string, user: User)/* Promise<User> */{
        return await this.userModel.findByIdAndUpdate({_id:id}, user,{
            new:true,
            runVailators: true,
    })
    }

    async deleteById(id:string): Promise<User>{
        return await this.userModel.findByIdAndDelete({_id:id},{
            new:true
        });
    }
}
