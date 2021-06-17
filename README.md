# Abap Unit test example

## This program will show an ALV list of sales orders based on customers and a rating based on the profit earned on each sales order

### User stories

- As a user I want to be able to select a customer and view sales orders

---

    - Given: I'm starting the program
    - When: I'm on the initial screen
    - Then: I can enter a customer number

- As a user when I search for sales orders, I only view the sales orders for a selected customer

---

    - Given: I've started the program AND entered a customer number
    - When: I execute the search
    - Then: I only see data for the selected customer

- As a user I want to see a class rating of the sales orders for the customer (Gold, Silver, Bronze)

---

    - Given: I've searched for a customer
    - When: The a sales order has more than $10 in profit
    - Then: Sales order has a gold rating

---

    - Given: I've searched for a customer
    - When: The a sales order has more than $5 AND less than 10 in profit
    - Then: Sales order has a silver rating

---

    - Given: I've searched for a customer
    - When: The a sales order has less than $5 in profit
    - Then: Sales order has a bronze rating

# Solution
- Two classes 
    - Business logic
    - Database calls
- Interface with types and methods
- Program 
