# DineNow - Online Food Ordering System

DineNow is an online food ordering system that allows users to browse the menu, add items to the cart, checkout, and manage orders. The system supports different user roles: admin, agent, and users. Admins can manage orders, agents can view order details, and users can place food orders.

---
## Features

- **User Roles**: Admin, Agent, and User roles with different access levels.
- **Sign Up & Login**: Role-based authentication for users, admin, and agents.
- **Browse Menu**: Users can browse the food menu and add items to their cart.
- **Checkout & Order**: Users can place an order by checking out their cart.
- **Admin Dashboard**: Admins can manage the status of orders and view agent statuses.
- **Agent View**: Agents can view assigned orders and update their status.

---
## Technologies Used

- **Java**: Core programming language.
- **JSP**: Java Server Pages for dynamic web content.
- **JDBC**: For database connectivity.
- **MySQL**: Database management system.
- **HTML & CSS**: For structuring and styling the pages.
- **Tailwind CSS**: For styling the user interface (optional, included via CDN).
---

## Installation and Setup

## Prerequisites

Before running this project, ensure that you have the following installed:

- **Java 11+**: Make sure Java is installed and configured in your system.
- **Apache Tomcat 9+**: For deploying the web application.
- **MySQL**: A MySQL database to store user data.
- **JDBC Driver**: MySQL JDBC Driver for connecting Java to MySQL.

### Step-by-Step Setup

1. **Clone the repository**:
    ```bash
    git clone https://github.com/yourusername/dinenow.git
    ```

2. **Configure the Database**:
    - Create a MySQL database:
        ```sql
        CREATE DATABASE dinenow_db;
        ```
    - Run the SQL scripts located in the `db_scripts` folder to set up the required tables.

3. **Set up JDBC Connection**:
    - Configure your `DbConnector.java` file with your MySQL database credentials:
        ```java
        public class DbConnector {
            public static Connection getConnection() throws SQLException {
                return DriverManager.getConnection("jdbc:mysql://localhost:3306/dinenow_db", "username", "password");
            }
        }
        ```

4. **Deploy to Apache Tomcat**:
    - Compile and build the project using your preferred IDE.
    - Place the `.war` file or the compiled folder in the `webapps` directory of your Tomcat installation.

5. **Access the Application**:
    - Start the Tomcat server:
        ```bash
        sudo systemctl start tomcat
        ```
    - Open a web browser and navigate to:
        ```url
        http://localhost:8080/dinenow/
        ```

### Optional: Using Tailwind CSS
- Tailwind CSS is included via CDN in the project. You can modify or remove it by editing the `<head>` section of the `index.jsp` file:
    ```html
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.0.0/dist/tailwind.min.css" rel="stylesheet">
    ```
    

Your application should now be up and running.

---
## Contact

For any inquiries or further information, please contact:

- **Project Owner**: Prasith De Alwis  
- **Email**: prasithdealwis@gmail.com  
- **GitHub**: [github.com/PrasithDeAlwis](https://github.com/PrasithDeAlwis)  
- **LinkedIn**: [linkedin.com/in/prasith-de-alwis](https://www.linkedin.com/in/prasith-de-alwis-506824334/)  


