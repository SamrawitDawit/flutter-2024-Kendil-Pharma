import { Injectable, CanActivate, ExecutionContext } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { Role } from './schemas/user.schema';
import * as jwt from 'jsonwebtoken';


@Injectable()
export class RolesGuard implements CanActivate {
  constructor(private readonly reflector: Reflector) {}

  canActivate(context: ExecutionContext): boolean {
    const requiredRoles = this.reflector.getAllAndOverride<Role[]>('roles', [
      context.getHandler(),
      context.getClass(),
    ]);
    if (!requiredRoles) {
      return true; // No required roles specified, allow access
    }

    const request = context.switchToHttp().getRequest();
    const authorizationHeader = request.headers.authorization;
    console.log(authorizationHeader);

    if (authorizationHeader) {
      const token = authorizationHeader.split(' ')[1];
      console.log(token)
      const secretKey = 'sifenlensayedi'; // Replace with your actual secret key

    try {
      let decodedToken: string | jwt.JwtPayload = jwt.verify(token, secretKey);

      if (typeof decodedToken === 'string') {
        decodedToken = jwt.decode(token) as jwt.JwtPayload;
      }

      const userId = decodedToken.id;
      const userRole = decodedToken.role;
      console.log(userId);
      console.log(userRole);

      const hasRequiredRole = requiredRoles.includes(userRole);
      return hasRequiredRole;
    }catch (error) {
      console.log("there was an error")
  }
}








    const user = request.user; // Assuming the user object is attached to the request during authentication
    console.log(user)

    if (!user || !user.roles) {
      return false; // User or user roles are not defined, deny access
    }

    // const { user } = context.switchToHttp().getRequest();
    // console.log(user);
    // if (!user || !user.role) {
    //   return false; // User or user role is not defined, deny access
    // }
    // return requiredRoles.includes(user.role);

    // const user ={
    //   name: 'Sifen',
    //   roles:[Role.PHARMACIST]
    // }
    return requiredRoles.some((role) => user.roles.includes(role))
  }
}


/* import { Reflector } from "@nestjs/core";
import {Injectable , CanActivate , ExecutionContext} from '@nestjs/common'
import { Role } from "./schemas/user.schema";



@Injectable()

export class RolesGuard implements CanActivate{
    constructor(private reflector: Reflector){}


    canActivate (context: ExecutionContext): boolean{

        const requiredRoles = this.reflector.getAllAndOverride<Role[]>('roles', [])

        context.getHandler(),
        context.getClass(),

        const request = context.switchToHttp().getRequest();
        const user = request.user;


        return requiredRoles.some((role) => user.roles.includes(role));
    }
} */
// role.guard.ts
// import { CanActivate, ExecutionContext, Injectable } from '@nestjs/common';
// import { Reflector } from '@nestjs/core';
// import { Role } from './schemas/user.schema';

// @Injectable()
// export class RoleGuard implements CanActivate {
//   constructor(private reflector: Reflector) {}

//   canActivate(context: ExecutionContext): boolean {
//     const requiredRoles = this.reflector.get<Role[]>('roles', context.getHandler());

//     if (!requiredRoles) {
//       return true; // No role validation needed, allow access
//     }

//     const request = context.switchToHttp().getRequest();
//     const user = request.user; // Assuming the user is available in the request after authentication

//     // Check if the user has at least one of the required roles
//     const hasRequiredRole = user.roles.some((role) => requiredRoles.includes(role));

//     return hasRequiredRole;
//   }
// }


