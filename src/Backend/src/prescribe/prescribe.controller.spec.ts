import { Test, TestingModule } from '@nestjs/testing';
import { PrescribeController } from './prescribe.controller';

describe('PrescribeController', () => {
  let controller: PrescribeController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [PrescribeController],
    }).compile();

    controller = module.get<PrescribeController>(PrescribeController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
