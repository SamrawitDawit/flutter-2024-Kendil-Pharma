import { Controller, Put, Param, Body, Delete, Get } from '@nestjs/common';
import { UpdateAccountDto } from './dto/update-account.dto';
import { UserService } from './user.service';
import { User } from './schema/useraccount.schema';

@Controller('users')
export class UpdateAccountController {
  constructor(private readonly userService: UserService) {}

  @Get(':id')
  async getUser(@Param('id') userId: string): Promise<User> {
    return this.userService.getUser(userId);
  }

  @Put(':id')
  async updateAccount(
    @Param('id') userId: string,
    @Body() updateAccountDto: UpdateAccountDto,
  ) {
    return this.userService.updateAccount(userId, updateAccountDto);
  }

  @Delete(':id')
  async deleteAccount(
    @Param('id') userId: string) {
    return this.userService.deleteAccount(userId);
  }
}













// import { Controller, Post, Patch, Delete, Body, Param } from '@nestjs/common';
// import { UserService } from './user.service';
// import { User } from './user.model';

// @Controller('users')
// export class UserController {
//   constructor(private readonly userService: UserService) {}

//   @Patch(':id/username')
//   async changeUsername(
//     @Param('id') userId: string,
//     @Body('username') newUsername: string,
//   ): Promise<User> {
//     return this.userService.changeUsername(userId, newUsername);
//   }

//   @Patch(':id/password')
//   async changePassword(
//     @Param('id') userId: string,
//     @Body('password') newPassword: string,
//   ): Promise<User> {
//     return this.userService.changePassword(userId, newPassword);
//   }

//   @Delete(':id')
//   async deleteAccount(@Param('id') userId: string): Promise<User> {
//     return this.userService.deleteAccount(userId);
//   }
// }