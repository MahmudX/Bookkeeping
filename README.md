# Bookkeeping App

## General Info

### How to run

1. Fire up 3 instances of the terminal
2. In terminal 1, Run `dotnet watch` in the `./BookKeeping/Api` folder
3. In terminal 2, Run `npm install` in the `./BookKeeping/presentation` folder
4. In terminal 2, Run `npm start` in the  `./BookKeeping/presentation` folder
5. In terminal 3, Run `npm run tailwind:watch` in the `./BookKeeping/presentation` folder

### How to add sample data

1. Go to <https://localhost:7264/swagger/index.html>.
2. In the swagger page, add data to the `Income` and `Expense` endpoints.
3. OR, run the provided **SQL** script in the `./` folder. (`DATA.sql`)

### Known issues

1. State for the Income and Expense portion is not being changed on the year change.
2. **Final Result** and **Cumulative Result** is not being attached to the DOM on first load. (To see the result, change the year)
