class Constants {
    
    private static readonly API_URL = "https://localhost:7264/api";

    public static readonly API_COST_GET_BY_YEAR = this.API_URL + "/cost/getbyyear?year=";
    public static readonly API_INCOME_GET_BY_YEAR = this.API_URL + "/income/getbyyear?year=";
    public static readonly API_INCOME_TYPE_GET_ALL = this.API_URL + "/IncomeType/GetAll?year=";
    public static readonly API_EXPENSE_TYPE_GET_ALL = this.API_URL + "/ExpenseType/getall?year=";

    public static readonly  API_INCOME_TYPE_UPDATE = this.API_URL + "/IncomeType/UpdateIncomeType";
    public static readonly  API_EXPENSE_TYPE_UPDATE = this.API_URL + "/ExpenseType/UpdateExpenseType";
}

export default Constants;