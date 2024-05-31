export class UpdatePrescribeDto{   
    readonly userId: string;
    readonly patientName: string;
    readonly medication: string;
    readonly dosageInstructions: string;
    readonly duration: string;    
}