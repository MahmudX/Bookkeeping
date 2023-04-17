import { useEffect, useState } from "react";
import Constants from "../Constants";
import Income from "../Models/Income";
import Cost from "../Models/Cost";
import IncomeType from "../Models/IncomeType";
import ExpenseType from "../Models/ExpenseType";
import FinancialRecordBase from "../Models/FinancialRecordBase";
import FinancialRecord from "../Models/FinancialRecord";

const Home = () => {


    const [selectedYear, setSelectedYear] = useState(2022);
    const [incomeForSelectedYear, setIncomeForSelectedYear] = useState<Income>();
    const [costForSelectedYear, setCostForSelectedYear] = useState<Cost>();
    const [incomeTypesForSelectedYear, setIncomeTypesForSelectedYear] = useState<IncomeType[]>([]);
    const [expenseTypesForSelectedYear, setExpenseTypesForSelectedYear] = useState<ExpenseType[]>([]);


    // reconciliation, final and cumulative
    const [incomeReconciliation, setIncomeReconciliation] = useState<number[]>([]);
    const [incomeFinal, setIncomeFinal] = useState<number[]>([]);
    const [incomeCumulative, setIncomeCumulative] = useState<number[]>([]);

    useEffect(() => {
        populateData();

    }, []);

    async function getIncomeAndCostByYear(year: number) {
        var response = await fetch(Constants.API_INCOME_GET_BY_YEAR + year);
        var data = await response.json() as Income;

        if (data.financialRecords.length < 12) {
            // add missing months to the array with 0 value
            for (let i = data.financialRecords.length; i < 12; i++) {
                data.financialRecords.push(
                    {
                        month: i + 1,
                        amount: 0
                    } as FinancialRecordBase
                );
            }
        }
        setIncomeForSelectedYear(data);


        var response2 = await fetch(Constants.API_COST_GET_BY_YEAR + year);
        var data2 = await response2.json() as Cost;

        if (data2.financialRecords.length < 12) {
            // add missing months to the array with 0 value
            for (let i = data2.financialRecords.length; i < 12; i++) {
                data2.financialRecords.push(
                    {
                        month: i + 1,
                        amount: 0
                    } as FinancialRecordBase
                );
            }
        }
        setCostForSelectedYear(data2);

    }


    async function getIncomeTypesForSelectedYear(year: number) {

        const response = await fetch(Constants.API_INCOME_TYPE_GET_ALL + year);
        const data = await response.json() as IncomeType[];
        data.forEach((incomeType) => {
            if (incomeType.financialRecords.length < 12) {
                for (let i = incomeType.financialRecords.length; i < 12; i++) {
                    incomeType.financialRecords.push(
                        {
                            month: i + 1,
                            amount: 0,
                            year: year
                        } as FinancialRecord
                    );
                }
            }
        });
        return data;
    }

    async function getExpenseTypesForSelectedYear(year: number) {
        const response = await fetch(Constants.API_EXPENSE_TYPE_GET_ALL + year);
        const data = await response.json() as ExpenseType[];

        data.forEach((expenseType) => {
            if (expenseType.financialRecords.length < 12) {
                for (let i = expenseType.financialRecords.length; i < 12; i++) {
                    expenseType.financialRecords.push(
                        {
                            month: i + 1,
                            amount: 0,
                            year: year
                        } as FinancialRecord
                    );
                }
            }
        }
        );
        return data;
    }

    async function populateData() {
        let year = selectedYear;

        await getIncomeAndCostByYear(year);
        const expenseType = await getExpenseTypesForSelectedYear(year);
        setExpenseTypesForSelectedYear(expenseType);
        const incomeType = await getIncomeTypesForSelectedYear(year);
        setIncomeTypesForSelectedYear(incomeType);

        // calculate reconciliation
        let reconciliation: number[] = [];
        for (let i = 0; i < 12; i++) {
            let income = incomeType.map((incomeType) => incomeType.financialRecords[i].amount).reduce((a, b) => a + b, 0);
            let expense = expenseType.map((expenseType) => expenseType.financialRecords[i].amount).reduce((a, b) => a + b, 0);
            reconciliation.push(income - expense);
        }
        setIncomeReconciliation(reconciliation);

        // calculate final
        // final result = reconciliation - income and cost difference

        let final: number[] = [];
        for (let i = 0; i < 12; i++) {
            let incomeCostDifference = incomeForSelectedYear!.financialRecords[i].amount - costForSelectedYear!.financialRecords[i].amount;
            final.push(reconciliation[i] - incomeCostDifference);
        }
        setIncomeFinal(final);


        // calculate cumulative
        // cumulative result = final result + previous cumulative result
        let cumulative: number[] = [];
        for (let i = 0; i < 12; i++) {
            if (i === 0) {
                cumulative.push(final[i]);
            } else {
                cumulative.push(final[i] + cumulative[i - 1]);
            }
        }

        setIncomeCumulative(cumulative);







    }

    const handleYearChange = (e: React.ChangeEvent<HTMLSelectElement>) => {
        let newYear = parseInt(e.target.value);
        setSelectedYear(newYear);
        populateData();
    };

    function updateIncomeType(incomeType: IncomeType) {
        fetch(Constants.API_INCOME_TYPE_UPDATE, {
            method: 'POST',
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(incomeType)
        }).then(response => response.json() as Promise<IncomeType>)
            .then(data => {
                // do nothing
            });
    }

    function updateExpenseType(expenseType: ExpenseType) {
        fetch(Constants.API_EXPENSE_TYPE_UPDATE, {
            method: 'POST',
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(expenseType)
        }).then(response => response.json() as Promise<ExpenseType>)

            .then(data => {
                // do nothing
            });
    }

    function updateIncomeAndExpenseTypes() {
        incomeTypesForSelectedYear?.forEach((incomeType) => {
            updateIncomeType(incomeType);
        });
        expenseTypesForSelectedYear?.forEach((expenseType) => {
            updateExpenseType(expenseType);
        });
    }


    return (
        <>
            <div className="container mx-auto">
                <div className="form-control w-full max-w-xs mb-4">
                    <label className="label">
                        <span className="label-text">Choose Year</span>
                    </label>
                    <select defaultValue={selectedYear} className="select select-bordered" onChange={handleYearChange}>
                        <option value={2021}>2021</option>
                        <option value={2022}>2022</option>
                    </select>
                </div>

                <table className="table w-full">
                    <thead>
                        <tr>
                            <th colSpan={14} className="border text-center">Year {selectedYear}</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td></td>
                            <td></td>
                            <td>Jan</td>
                            <td>Feb</td>
                            <td>Mar</td>
                            <td>Apr</td>
                            <td>May</td>
                            <td>Jun</td>
                            <td>Jul</td>
                            <td>Aug</td>
                            <td>Sep</td>
                            <td>Oct</td>
                            <td>Nov</td>
                            <td>Dec</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>Income</td>
                            {
                                incomeForSelectedYear?.financialRecords.map((income, index) => {
                                    return <td key={index} className="bg-base-200">{income.amount}</td>
                                })
                            }
                        </tr>
                        <tr>
                            <td></td>
                            <td>Cumulative Income</td>
                            {
                                incomeForSelectedYear?.financialRecords.map((income, index) => {
                                    return <td key={index} className="bg-base-200">
                                        {
                                            incomeForSelectedYear.financialRecords.slice(0, index + 1).reduce((a, b) => a + b.amount, 0)
                                        }
                                    </td>
                                })
                            }
                        </tr>
                        <tr>
                            <td></td>
                            <td>Cost</td>
                            {
                                costForSelectedYear?.financialRecords.map((cost, index) => {
                                    return <td key={index} className="bg-base-200">{cost.amount}</td>
                                })
                            }
                        </tr>
                        <tr className="bordered">
                            <td></td>
                            <td>Cumulative Cost</td>
                            {
                                costForSelectedYear?.financialRecords.map((cost, index) => {
                                    return <td key={index} className="bg-base-200">
                                        {
                                            costForSelectedYear.financialRecords.slice(0, index + 1).reduce((a, b) => a + b.amount, 0)
                                        }
                                    </td>
                                })
                            }
                        </tr>
                        <tr>
                            <td></td>
                            <td>Result</td>
                            {
                                Array(12).fill(0).map((_, index) => {
                                    return <td key={index} className="bg-base-200">
                                        {
                                            (incomeForSelectedYear?.financialRecords[index].amount ?? 0)
                                            - (costForSelectedYear?.financialRecords[index].amount ?? 0)
                                        }
                                    </td>
                                })
                            }
                        </tr>
                        <tr>
                            <td></td>
                            <td colSpan={13} className="text-center">
                                Reconciliation
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td colSpan={13} className="text-center">Income</td>

                        </tr>
                        {
                            incomeTypesForSelectedYear?.map((incomeType, index) => {
                                return (
                                    <tr key={index}>
                                        <td></td>
                                        <td>{incomeType.name}</td>
                                        {
                                            (incomeType.financialRecords ?? Array(12).fill({ amount: 0 } as FinancialRecord)).map((record, recordIndex) => {
                                                return <td key={recordIndex} className="bg-accent" id={`iT-${index}-${recordIndex}`}>
                                                    <input defaultValue={record.amount} style={{ width: '50px' }} className="input input-sm"
                                                        onChange={(event) => {
                                                            const updatedRecords = [...incomeType.financialRecords!];
                                                            updatedRecords[recordIndex] = {
                                                                ...updatedRecords[recordIndex],
                                                                amount: parseInt(event.target.value)
                                                            };
                                                            incomeType.financialRecords = updatedRecords;
                                                            setIncomeTypesForSelectedYear([...incomeTypesForSelectedYear!]);

                                                        }}
                                                    />
                                                </td>
                                            })
                                        }
                                    </tr>
                                )
                            })
                        }

                        <tr>
                            <td></td>
                            <td colSpan={13} className="text-center">Expense</td>
                        </tr>

                        {
                            expenseTypesForSelectedYear?.map((expenseType, index) => {
                                return (
                                    <tr key={index}>
                                        <td></td>
                                        <td>{expenseType.name}</td>
                                        {
                                            (expenseType.financialRecords ?? Array(12).fill(0)).map((record, recordIndex) => {

                                                return <td key={recordIndex} className="bg-accent" id={`eT-${index}-${recordIndex}`}>
                                                    <input defaultValue={record.amount} style={{ width: '50px' }} className="input input-sm"
                                                        onChange={(event) => {
                                                            const updatedRecords = [...expenseType.financialRecords!];
                                                            updatedRecords[recordIndex] = {
                                                                ...updatedRecords[recordIndex],
                                                                amount: parseInt(event.target.value),
                                                            };
                                                            expenseType.financialRecords = updatedRecords;
                                                            setExpenseTypesForSelectedYear([...expenseTypesForSelectedYear!]);
                                                        }}
                                                    />
                                                </td>
                                            })
                                        }
                                    </tr>
                                )
                            })
                        }


                        <tr>
                            <td></td>
                            <td>Reconciliation Result</td>
                            {
                                // Array(12).fill(0).map((_, index) => {
                                //     return <td key={index} className="bg-base-200">
                                //         {
                                //             (incomeTypesForSelectedYear?.reduce((a, b) => a + (b.financialRecords![index].amount ?? 0), 0) ?? 0)
                                //             - (expenseTypesForSelectedYear?.reduce((a, b) => a + (b.financialRecords![index].amount ?? 0), 0) ?? 0)

                                //         }
                                //     </td>
                                // })

                                incomeReconciliation?.map((record, index) => {
                                    return <td key={index} className="bg-base-200">{record}</td>
                                })



                            }
                        </tr>
                        <tr>
                            <td></td>
                            <td>Final Result</td>
                            {
                                // Array(12).fill(0).map((_, index) => {
                                //     return <td key={index} className="bg-base-200">
                                //         {
                                //             // (incomeForSelectedYear?.financialRecords[index].amount ?? 0)
                                //             // - (costForSelectedYear?.financialRecords[index].amount ?? 0)
                                //             // + (incomeTypesForSelectedYear?.reduce((a, b) => a + (b.financialRecords![index].amount ?? 0), 0) ?? 0)
                                //             // - (expenseTypesForSelectedYear?.reduce((a, b) => a + (b.financialRecords![index].amount ?? 0), 0) ?? 0)

                                //             // reconciliation result - income and cost difference
                                //             (incomeTypesForSelectedYear?.reduce((a, b) => a + (b.financialRecords![index].amount ?? 0), 0) ?? 0)
                                //             - (expenseTypesForSelectedYear?.reduce((a, b) => a + (b.financialRecords![index].amount ?? 0), 0) ?? 0)
                                //             - ((incomeForSelectedYear?.financialRecords[index].amount ?? 0)
                                //                 - (costForSelectedYear?.financialRecords[index].amount ?? 0))

                                //         }
                                //     </td>
                                // })

                                incomeFinal?.map((record, index) => {
                                    return <td key={index} className="bg-base-200">{record}</td>
                                })


                            }
                        </tr>
                        <tr>
                            <td></td>
                            <td>Cumulative Result</td>

                            {
                                // Array(12).fill(0).map((_, index) => {
                                //     return <td key={index} className="bg-base-200">
                                //         {
                                //             // 1st cell is just like final result
                                //             // from 2nd cell, 2nd cell of final result + 1st cell of cumulative result (which is final result)
                                //             // 3rd cell = 3rd cell of final result + 2nd cell of cumulative result
                                //             // 4th cell = 4th cell of final result + 3rd cell of cumulative result
                                //             // do this for all remaining cells

                                //             (index === 0) ?
                                //                 (incomeTypesForSelectedYear?.reduce((a, b) => a + (b.financialRecords![index].amount ?? 0), 0) ?? 0)
                                //                 - (expenseTypesForSelectedYear?.reduce((a, b) => a + (b.financialRecords![index].amount ?? 0), 0) ?? 0)
                                //                 - ((incomeForSelectedYear?.financialRecords[index].amount ?? 0)
                                //                     - (costForSelectedYear?.financialRecords[index].amount ?? 0))
                                //                 :
                                //                 (incomeTypesForSelectedYear?.reduce((a, b) => a + (b.financialRecords![index].amount ?? 0), 0) ?? 0)
                                //                 - (expenseTypesForSelectedYear?.reduce((a, b) => a + (b.financialRecords![index].amount ?? 0), 0) ?? 0)
                                //                 - ((incomeForSelectedYear?.financialRecords[index].amount ?? 0)
                                //                     - (costForSelectedYear?.financialRecords[index].amount ?? 0))
                                //                 + (incomeTypesForSelectedYear?.reduce((a, b) => a + (b.financialRecords![index - 1].amount ?? 0), 0) ?? 0)
                                //                 - (expenseTypesForSelectedYear?.reduce((a, b) => a + (b.financialRecords![index - 1].amount ?? 0), 0) ?? 0)
                                //                 - ((incomeForSelectedYear?.financialRecords[index - 1].amount ?? 0)
                                //                     - (costForSelectedYear?.financialRecords[index - 1].amount ?? 0))



                                //         }
                                //     </td>
                                //})

                                incomeCumulative?.map((record, index) => {
                                    return <td key={index} className="bg-base-200">{record}</td>
                                })
                            }

                        </tr>
                    </tbody>
                </table>


                <button className="btn btn-primary mt-3 mb-10 float-right" onClick={
                    () => {
                        //console.log(incomeTypesForSelectedYear);
                        //console.log(expenseTypesForSelectedYear);
                        updateIncomeAndExpenseTypes();
                    }
                }>
                    Save
                </button>

            </div>

        </>
    );
};

export default Home;