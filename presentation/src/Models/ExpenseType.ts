import { UUID } from "crypto";
import FinancialRecord from "./FinancialRecord";

type ExpenseType = {
    id: UUID;
    name: string;
    financialRecords: FinancialRecord[];
};

export default ExpenseType;