import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { MedicineModule } from './medicine/medicine.module';
import { ConfigModule } from '@nestjs/config';
import { MongooseModule } from '@nestjs/mongoose';
import { AuthModule } from './auth/auth.module';
import { APP_GUARD } from '@nestjs/core';
import { RolesGuard } from './auth/role.guard';
import { PrescribeModule } from './prescribe/prescribe.module';
import { UpdateAccountController } from './user/user.controller';
import { UserService } from './user/user.service';
import { UserModule } from './user/user.module';
import { OrderModule } from './order/order.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      envFilePath:'.env',
      isGlobal:true
    }),
    MongooseModule.forRoot(process.env.DB_URI),
    MedicineModule,
    AuthModule,
    PrescribeModule,
    OrderModule,
    UserModule],
  controllers: [AppController],
  providers: [AppService,
  {
    provide: APP_GUARD,
    useClass: RolesGuard,
  }],
})
export class AppModule {}
