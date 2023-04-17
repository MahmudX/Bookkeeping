import { UUID } from "crypto";

type FinancialRecord = {
    id: UUID;
    month: number;
    amount: number;
    year: number;
}

export default FinancialRecord;