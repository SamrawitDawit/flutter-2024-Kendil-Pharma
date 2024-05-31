import {SetMetadata} from '@nestjs/common'
import { Role } from './schemas/role2.enum';

export const Roles = (...roles:Role[]) => SetMetadata('roles', roles);