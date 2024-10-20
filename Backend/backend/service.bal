import ballerina/http;
import ballerina/io;
import ballerina/sql;
import ballerinax/mysql;

type User record {
    int id?; // Optional ID
    string first_name;
    int age;
    string email;
    string phone_number;
    string password; // Ensure this is handled securely in real applications
};

type Product record {
    int product_id?; // Optional product ID
    string product_name;
    int price;
    string category;
    string product_details;
    string? image_path; // Optional image path
};

// Configurable variables for MySQL connection
configurable string HOST = ?;
configurable int PORT = ?;
configurable string USER = ?;
configurable string PASSWORD = ?;
configurable string DATABASE = ?;

// Initialize MySQL client
final mysql:Client dbClient = check new (host = HOST, port = PORT, user = USER, password = PASSWORD, database = DATABASE);

service /api on new http:Listener(8080) {

    // POST /api/addUser - Add a new user
    resource function post addUser(@http:Payload User user) returns json|error {
        int|error result = addUser(user);

        if result is int {
            // Respond with a success message and the new user's ID
            json response = {message: "User added successfully", userId: result};
            return response;
        } else {
            // Log and return the error message
            io:println("Error adding user: ", result.message());
            return error("Failed to add user: " + result.message());
        }
    }

    // POST /api/addProduct - Add a new product
    resource function post addProduct(@http:Payload Product product) returns json|error {
        int|error result = addProduct(product);

        if result is int {
            // Respond with a success message and the new product's ID
            json response = {message: "Product added successfully", productId: result};
            return response;
        } else {
            // Log and return the error message
            io:println("Error adding product: ", result.message());
            return error("Failed to add product: " + result.message());
        }
    }

    // POST /api/login - Handle user login
    resource function post login(@http:Payload json payload) returns json|error {
        string email = (check payload.email).toString();
        string password = (check payload.password).toString();

        string|error result = loginByEmailPassword(email, password);

        if result is string {
            // Successful login, return welcome message
            json response = {message: "User login successful", welcome: result};
            return response;
        } else {
            // Return error message if login fails
            return error("Failed to login: " + result.message());
        }
    }

    // GET /api/products - Retrieve all product details
    resource function get products() returns Product[]|error {
    Product[]|error products = getAllProducts();

    if products is Product[] {
        // Return the list of products as a JSON array
        return products;
    } else {
        // Return error message if retrieving products failed
        return error("Failed to retrieve products: " + products.message());
    }
}

}

// Function to retrieve all products from the database
isolated function getAllProducts() returns Product[]|error {
    // Initialize an empty array to collect products
    Product[] products = [];

    // Create a stream from the query
    stream<Product, error?> resultStream = dbClient->query(`SELECT product_id, product_name, price, category, product_details, image_path FROM products`);

    // Collect products from the result stream
    check from Product product in resultStream
        do {
            products.push(product);
        };

    // Close the result stream to release resources
    check resultStream.close();

    // Return the list of products
    return products;
}

// Function to add a user to the database
isolated function addUser(User newUser) returns int|error {
    sql:ParameterizedQuery insertQuery = `INSERT INTO users (first_name, age, email, phone_number, password) 
                                          VALUES (${newUser.first_name}, ${newUser.age}, ${newUser.email}, 
                                          ${newUser.phone_number}, ${newUser.password})`;

    sql:ExecutionResult result = check dbClient->execute(insertQuery);
    int|string? lastInsertId = result.lastInsertId;

    if lastInsertId is int {
        return lastInsertId;
    } else {
        return error("Failed to retrieve the last inserted ID");
    }
}

// Function to add a product to the database
isolated function addProduct(Product newProduct) returns int|error {
    // Secure parameterized query for inserting product data
    sql:ParameterizedQuery insertQuery = `INSERT INTO products 
                                          (product_name, price, category, product_details, image_path) 
                                          VALUES (${newProduct.product_name}, 
                                                  ${newProduct.price}, 
                                                  ${newProduct.category}, 
                                                  ${newProduct.product_details},
                                                  ${newProduct.image_path})`;

    sql:ExecutionResult result = check dbClient->execute(insertQuery);
    int|string? lastInsertId = result.lastInsertId;

    if lastInsertId is int {
        return lastInsertId;
    } else {
        return error("Failed to retrieve the last inserted ID");
    }
}

// Function to login using email and password
isolated function loginByEmailPassword(string email, string password) returns string|error {
    io:println("Attempting to log in user with email: ", email);
    
    // Log the SQL query before execution
    sql:ParameterizedQuery selectQuery = `SELECT first_name, password FROM users WHERE email = ${email}`;
    io:println("Executing SQL query: ", selectQuery);

    // Execute the query and fetch the user row
    record {|string first_name; string password;|}|sql:Error? user = dbClient->queryRow(selectQuery);

    if user is sql:Error {
        // Handle the SQL error
        return error("Error executing the query: " + user.message());
    } else if user is record {|string first_name; string password;|} {
        // Check if the provided password matches the stored password
        if user.password == password {
            return "Login successful. Welcome, " + user.first_name + "!";
        } else {
            return error("Invalid email or password");
        }
    } else {
        // If no user is found
        return error("User not found");
    }
}
