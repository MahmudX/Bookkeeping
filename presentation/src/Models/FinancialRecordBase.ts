import { UUID } from "crypto";

type FinancialRecordBase = {
    id: UUID;
    month: number;
    amount: number;
}

export default FinancialRecordBase;