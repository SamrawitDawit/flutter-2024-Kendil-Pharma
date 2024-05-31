import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { User, UserDocument } from './schema/useraccount.schema';
import { UpdateAccountDto } from './dto/update-account.dto';

@Injectable()
export class UserService {
  constructor(@InjectModel(User.name) private readonly userModel: Model<UserDocument>) {}

  async getUser(userId: string): Promise<User> {
    return this.userModel.findById(userId);
  }

  async updateAccount(userId: string, updateAccountDto: UpdateAccountDto): Promise<User> {
    const updatedUser = await this.userModel.findByIdAndUpdate(
      userId,
      updateAccountDto,
      { new: true },
    );
    return updatedUser;
  }

  async deleteAccount(userId: string): Promise<User> {
    const deletedUser = await this.userModel.findByIdAndDelete(userId);
    return deletedUser;
  }
}




















// import { Injectable } from '@nestjs/common';
// import { InjectModel } from '@nestjs/mongoose';
// import { Model } from 'mongoose';
// import { User } from './user.model';
// import  * as bcrypt from 'bcryptjs';

// @Injectable()
// export class UserService {
//   constructor(@InjectModel('User') private readonly userModel: Model<User>) {}

//   async changeUsername(userId: string, newUsername: string): Promise<User> {
//     const user = await this.userModel.findByIdAndUpdate(
//       userId,
//       { username: newUsername },
//       { new: true },
//     );
//     return user;
//   }

//   async changePassword(userId: string, newPassword: string): Promise<User> {
//     const hashedPassword = await bcrypt.hash(newPassword, 10);
//     const user = await this.userModel.findByIdAndUpdate(
//       userId,
//       { password: hashedPassword },
//       { new: true },
//     );
//     return user;
//   }

//   async deleteAccount(userId: string): Promise<User> {
//     const user = await this.userModel.findByIdAndDelete(userId);
//     return user;
//   }
// }