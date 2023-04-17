import { UUID } from "crypto";
import FinancialRecord from "./FinancialRecord";


type IncomeType = {
    id: UUID;
    name: string;
    financialRecords: FinancialRecord[];
};

export default IncomeType;