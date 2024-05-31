import { Injectable, NestMiddleware } from '@nestjs/common';
import { Request, Response, NextFunction } from 'express';
import { JwtService } from '@nestjs/jwt';
import { AuthService } from '../auth.service';

@Injectable()
export class AttachUserToRequestBodyMiddleware implements NestMiddleware {
  constructor(
    private readonly jwtService: JwtService,
    private readonly authService: AuthService,
    ) {}

  async use(req: Request, res: Response, next: NextFunction) {
    try {
      const token = req.headers.authorization?.split(' ')[1]; // Assuming token is sent in the "Authorization" header as "Bearer <token>"
      if (token) {
        const decodedToken = await this.jwtService.verifyAsync(token);
        const userId = decodedToken.sub; // Assuming the user ID is stored in the "sub" field of the token payload
        // Retrieve the user information based on the user ID
        const user = await this.authService.getUserById(userId);
        console.log(user)
  
        // Attaching the user property to the request body
        req.body.user = user;
      }
    } catch (error) {
      // Handle authentication or user retrieval errors here
    }

    next();
  }
}


// import { Injectable, NestMiddleware } from '@nestjs/common';
// import { Request, Response, NextFunction } from 'express';

// enum Role {
//   Client = 'Client',
//   Pharmacist = 'Pharmacist',
// }

// interface User {
//   name: string;
//   email: string;
//   password: string;
//   role: Role;
// }

// @Injectable()
// export class AuthorizationMiddleware implements NestMiddleware {
//   use(req: Request, res: Response, next: NextFunction) {
//     const user = req.user as User;

//     if (user.role !== Role.Pharmacist) {
//       return res.status(403).json({ message: 'Access denied' });
//     }

//     next();
//   }
// }