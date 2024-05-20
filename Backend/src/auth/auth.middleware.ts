// auth.middleware.ts
import { Injectable, NestMiddleware } from '@nestjs/common';
import { Request, Response, NextFunction } from 'express';
import * as jwt from 'jsonwebtoken';

interface JwtPayload {
    // Define the structure of your JWT payload
    // For example:
    userId: string;
    // Add other fields if present in your JWT payload
}

@Injectable()
export class AuthMiddleware implements NestMiddleware {
    use(req: Request & { user?: JwtPayload }, res: Response, next: NextFunction) {
        const authHeader = req.headers['authorization'];
        if (authHeader && authHeader.startsWith('Bearer ')) {
            const token = authHeader.split(' ')[1];
            try {
                const decoded = jwt.verify(token, 'your_secret_key') as JwtPayload;
                req.user = decoded;
            } catch (error) {
                console.error('JWT verification failed:', error);
            }
        }
        next();
    }
}
