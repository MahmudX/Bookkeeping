import { UUID } from "crypto";
import FinancialRecordBase from "./FinancialRecordBase";

type Income = {
    id: UUID;
    year: number;
    financialRecords: FinancialRecordBase[];
}


export default Income;