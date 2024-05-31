import { Schema, Document, model } from 'mongoose';

export enum RoleName {
    CLIENT = 'Client',
    PHARMACIST = 'Pharmacist',
}

export interface Role extends Document {
  name: RoleName;
  permissions: string[];
}

const roleSchema = new Schema<Role>({
  name: { type: String, required: true, unique: true, enum: Object.values(RoleName) },
  permissions: [{ type: String }],
});

export const RoleModel = model<Role>('Role', roleSchema);