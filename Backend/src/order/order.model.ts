

import { Document } from 'mongoose';

export interface Order extends Document {
  userId: string;
  medicineId: string;
  quantity: string;
  date: string;
}
