import { UUID } from "crypto";
import FinancialRecordBase from "./FinancialRecordBase";

type Cost = {
    id: UUID;
    year: number;
    financialRecords: FinancialRecordBase[];
}


export default Cost;