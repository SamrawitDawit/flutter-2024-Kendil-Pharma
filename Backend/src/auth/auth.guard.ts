// auth.guard.ts

import { Injectable, CanActivate, ExecutionContext } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { Observable } from 'rxjs';

@Injectable()
export class AuthGuard implements CanActivate {

    constructor(private jwtService: JwtService) {}

    canActivate(context: ExecutionContext): boolean | Promise<boolean> | Observable<boolean> {
        const request = context.switchToHttp().getRequest();
        const token = request.headers.authorization?.split(' ')[1]; // Extract token from header

        if (!token) {
        return false; // No token provided
        }

        try {
        const decoded = this.jwtService.verify(token);
        request.user = decoded; // Attach user information to the request
        return true; // User is authenticated
        } catch (error) {
        return false; // Token is invalid
        }
    }
}
