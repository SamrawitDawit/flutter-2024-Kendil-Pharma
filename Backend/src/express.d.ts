import { Request } from 'express';
import { JwtPayload } from './jwtpayload.interface'; // Update the path if needed

declare module 'express' {
  interface Request {
    user?: JwtPayload; // Add the user property to Request
  }
}
