// import { Body, Controller, Delete, Get, Param, Post, Put, Query, Req, UseGuards} from '@nestjs/common';
// import { OrderService } from './order.service';
// import { Order } from './order.schema';
// import { CreateOrderDto } from './dto/create-order.dto';
// import { UpdateOrderDto } from './dto/update-order.dto';
// import { Request, query } from 'express';
// import { AuthGuard } from '@nestjs/passport';
// import { Query as ExpressQuery } from 'express-serve-static-core';
// @Controller('orders')
// export class OrderController {
//     constructor(private orderService: OrderService){}
//     @Get()
//     @UseGuards(AuthGuard())
//     async getAllOrders(@Query() query: ExpressQuery): Promise<Order[]> {
//         return this.orderService.findAll(query)
//     }
//     @Post('/create')
//     @UseGuards(AuthGuard())
//     async createOrder(
//         @Body()
//         order: CreateOrderDto,
//         @Req() req,
//     ): Promise<Order>{
//         return this.orderService.create(order, req.user)
//     }
//     @Get(':id')
//     async getOrder(
//         @Param('id')
//         id: string
//     ): Promise<Order[]> {
//         return this.orderService.findById(id)
//     }
//     @Put(':id')
//     async updateOrder(
//         @Param('id')
//         id: string,
//         @Body()
//         order: UpdateOrderDto,
//     ): Promise<Order>{
//         return this.orderService.update(id, order)
//     }
//     @Delete(':id')
//     async deleteOrder(
//         @Param('id')
//         id: string,
//     ): Promise<Order>{
//         return this.orderService.delete(id);
//     }
// }
import { Controller, Get, Post, Body, Request, UseGuards } from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { Roles } from '../auth/roles.decorator';
import { RoleGuard } from 'src/auth/role.guard';
import { OrderService } from './order.service';
import { CreateOrderDto } from './dto/create-order.dto';
import { Role } from 'src/auth/schemas/user.schema';
@Controller('orders')
export class OrderController {
  constructor(private readonly orderService: OrderService) {}

  @Post('create')
//   @UseGuards(AuthGuard(), RoleGuard)
//   @Roles(Role.CLIENT)
  create(@Body() createOrderDto: CreateOrderDto, @Request() req) {
    return this.orderService.create({ ...createOrderDto, userId: req.user._id });
  }

  @Get()
  @UseGuards(AuthGuard())
  findAll(@Request() req) {
    return this.orderService.findAll(req.user.id);
  }

//   @Get('admin')
//   @UseGuards(AuthGuard(), RoleGuard)
//   @Roles(Role.PHARMACIST)
//   findAllForAdmin() {
//     return this.orderService.findAllForAdmin();
//   }
}
