// import { Injectable, NotFoundException} from '@nestjs/common';
// import { Order } from './order.schema';
// import mongoose from 'mongoose';
// import { InjectModel } from '@nestjs/mongoose';
// import { Query} from 'express-serve-static-core';
// import { User } from 'src/auth/schemas/user.schema';
// import { Medicine } from 'src/medicine/schemas/medicine.schema';
// @Injectable()
// export class OrderService {
//     constructor(
//         @InjectModel(Order.name)
//         private orderModel: mongoose.Model<Order>
//     ) {}
//     async findAll(query: Query): Promise<Order[]>{
//         const resPerPage = 10
//         const currentPage = Number(query.page) || 1
//         const skip = resPerPage *(currentPage - 1)
//         const orders = await this.orderModel.find().limit(resPerPage).skip(skip);
//         return orders
//     }
//     async create(order: Order, user: User): Promise<Order>{
//         const data = Object.assign(order, {user: user._id})
//         const res = await this.orderModel.create(data);
//         return res;
//     }
//     async findById(user_id: String): Promise<Order[]>{
//         const order = await this.orderModel.find({user_id});
//
//         if (!order){
//             throw new NotFoundException("Order not found.");
//         }
//         return order;
//     }
//     async update(id: String, order: Order): Promise<Order>{
//         return await this.orderModel.findByIdAndUpdate(id, order, {
//             new: true,
//             runValidators: true,
//         });
//     }
//     async delete(id: String): Promise<Order>{
//         return await this.orderModel.findByIdAndDelete(id);
//     }
// }
//
import { Injectable } from '@nestjs/common';
import { Model } from 'mongoose';
import { InjectModel } from '@nestjs/mongoose';
import { Order } from 'src/order/order.model';
import { CreateOrderDto } from './dto/create-order.dto';

@Injectable()
export class OrderService {
  constructor(@InjectModel('Order') private readonly orderModel: Model<Order>) {}

  async create(createOrderDto: CreateOrderDto): Promise<Order> {
    const createdOrder = new this.orderModel(createOrderDto);
    return createdOrder.save();
  }

  async findAll(userId: string): Promise<Order[]> {
    return this.orderModel.find({ userId }).exec();
  }

  async findAllForAdmin(): Promise<Order[]> {
    return this.orderModel.find().exec();
  }
}