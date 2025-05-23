import { TestBed } from '@angular/core/testing';

import { ApiBaseRequestService } from './api-base-request.service';

describe('ApiBaseRequestService', () => {
  let service: ApiBaseRequestService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ApiBaseRequestService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
