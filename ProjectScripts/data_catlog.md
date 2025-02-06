# Data Catalog
Gold Layer is the final layer designed to represent data to support data analytical use cases.<br>
It contains **FACTS** & **DIMENSIONS** tables.<br>
This layer is designed in such a way that **non-technical, stake holders or business owners** can easily understand. 

## View: `gold.dim_customers`

| **Column Name**      | **Description**                                                 | **Data Type** |
|----------------------|-----------------------------------------------------------------|---------------|
| `customer_key`       | Unique key for each customer.                                  | Integer       |
| `customer_id`        | Customer's ID.                                                 | Integer       |
| `customer_number`    | Customer's unique number (Alpha Numeric eg: AW0001100).         | Varchar       |
| `customer_firstname` | Customer's first name.                                         | Varchar       |
| `customer_lastname`  | Customer's last name.                                          | Varchar       |
| `birthdate`          | Customer's birth date (Format: YYYY-MM-DD).                    | Date          |
| `country`            | Customer's country (eg: Australia, United States).             | Varchar       |
| `marital_status`     | Customer's marital status (eg: Married, Single).               | Varchar       |
| `gender`             | Customer's gender (eg: Female, Male).                          | Varchar       |
| `create_date`        | Date when the customer record was created (Format: YYYY-MM-DD).| Date          |

---

## View: `gold.dim_products`

| **Column Name**       | **Description**                                                   | **Data Type** |
|-----------------------|-------------------------------------------------------------------|---------------|
| `product_key`         | Unique key for each product.                                     | Integer       |
| `product_id`          | Product's ID.                                                    | Integer       |
| `product_number`      | Product's unique number (Alpha Numeric eg: FR-R92B-58).           | Varchar       |
| `product_name`        | Product name (Alpha Numeric eg: HL Road Frame - Black- 58).       | Varchar       |
| `category_id`         | Category ID (Alpha Numeric eg: CO_RF).                           | Varchar       |
| `category`            | Product's category.                                              | Varchar       |
| `subcategory`         | Product's subcategory.                                           | Varchar       |
| `maintenance`         | Product maintenance status (eg: YES, NO).                        | Varchar       |
| `product_cost`        | Product cost (Numerical eg: 1898).                               | Numeric       |
| `product_line`        | Product line.                                                    | Varchar       |
| `product_start_date`  | Start date (Format: YYYY-MM-DD).                                 | Date          |

---

## View: `gold.sales_orders`

| **Column Name**       | **Description**                                                   | **Data Type** |
|-----------------------|-------------------------------------------------------------------|---------------|
| `order_number`        | Sales order number (Alpha Numeric eg: SO43697).                  | Varchar       |
| `product_key`         | Foreign key CONNECTING to `dim_products`.                        | Integer       |
| `customer_key`        | Foreign key CONNECTING to `dim_customers`.                       | Integer       |
| `order_date`          | The date the order was placed (Format: YYYY-MM-DD).              | Date          |
| `shipping_date`       | The date the order was shipped (Format: YYYY-MM-DD).             | Date          |
| `due_date`            | The date the order is due to be delivered (Format: YYYY-MM-DD).  | Date          |
| `sales_amount`        | Total sales amount.                                              | Numeric       |
| `quantity`            | Quantity of items sold.                                          | Integer       |
| `price`               | Price of the product.                                            | Numeric       |
