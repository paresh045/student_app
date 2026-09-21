using {student.db as model} from '../db/schema';

service StudentAPIService {
    entity StudentSet as projection on model.Students;
    entity Authors    as projection on model.Authors; //due to Composition we need not to expose Books table here//Books will se in metadata
}
