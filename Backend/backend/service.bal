import ballerina/http;
import ballerina/io;
import ballerina/sql;
import ballerinax/mysql;

type User record {
    int id?;
    string first_name;
    int age;
    string email;
    string phone_number;
    string password;
};

type Product record {
    int product_id?;
    string product_name;
    int price;
    string category;
    string product_details;
    string? image_path;
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

    // resource function post addProduct1(http:Caller caller, http:Request req) returns error? {

    //     // Check if the content type is multipart/form-data
    //     string? contentType = req.getContentType();
    //     if contentType is string && contentType.startsWith(mime:MULTIPART_FORM_DATA) {
    //         // Extract multipart data from the request
    //         mime:Entity[] parts = check req.getBodyParts();

    //         string productName = "";
    //         string category = "";
    //         string productDetails = "";
    //         decimal price = 0;
    //         string imageFilePath = "";

    //         // Iterate through parts and extract data
    //         foreach var part in parts {
    //             // Retrieve the Content-Disposition header to get part name
    //             var contentDispositionResult = part.getHeader(mime:CONTENT_DISPOSITION);

    //             if contentDispositionResult is string {
    //                 // Manually extract parameters from the Content-Disposition header
    //                 map<string> parameters = extractContentDispositionParams(contentDispositionResult);
    //                 string? partName = parameters["name"];

    //                 if partName == "product_name" {
    //                     productName = check part.getText();
    //                 } else if partName == "price" {
    //                     // Get price as text and convert to decimal
    //                     string priceResult = check part.getText();
    //                     price = check decimal:fromString(priceResult);
    //                 } else if partName == "category" {
    //                     category = check part.getText();
    //                 } else if partName == "product_details" {
    //                     productDetails = check part.getText();
    //                 } else if partName == "image" {
    //                     // Handle image part
    //                     string? fileName = parameters["filename"];
    //                     if fileName is string {
    //                         byte[] fileContent = check part.getByteArray();

    //                         // Save the image to a file
    //                         string filePath = "./uploads/" + fileName;
    //                         check io:fileWriteBytes(filePath, fileContent);

    //                         imageFilePath = filePath;
    //                     }
    //                 }
    //             } else {
    //                 log:printError("Failed to retrieve Content-Disposition header: ", contentDispositionResult);
    //             }
    //         }

    //         // Log the product details and file path for debugging
    //         log:printInfo("Product Name: " + productName);
    //         log:printInfo("Category: " + category);
    //         log:printInfo("Product Details: " + productDetails);
    //         log:printInfo("Price: " + price.toString());
    //         log:printInfo("Image saved at: " + imageFilePath);

    //         // Return a success response to the client
    //         json response = {message: "Product added successfully", image_path: imageFilePath};
    //         check caller->respond(response);
    //     } else {
    //         // If content type is not multipart, return an error
    //         // json errorResponse = {error: "Invalid content type. Please upload multipart/form-data"};
    //         // check caller->respond(errorResponse);
    //     }

    // }
}

// function extractContentDispositionParams(string contentDisposition) returns map<string> {
//     map<string> params = {};

//     int start1 = 0;
//     int end = 0;
//     string key = "";
//     string value = "";

//     while (true) {
//         // Find the next semicolon
//         end = contentDisposition.indexOf(";", start1);
//         if (end == -1) {
//             end = contentDisposition.length();
//         }

//         // Get the part before the semicolon
//         string part = contentDisposition.substring(start, end).trim();

//         // Check if there is an equal sign
//         int equalIndex = part.indexOf("=");
//         if (equalIndex != -1) {
//             key = part.substring(0, equalIndex).trim();
//             value = part.substring(equalIndex + 1).trim().replace("\"", "");
//             params[key] = value;
//         }

//         // Move to the next part
//         if (end == contentDisposition.length()) {
//             break; // No more parts
//         }
//         start = end + 1;
//     }

//     return params;
// }

// Function to retrieve all products from the database

// Function to add a user to the database

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
                                          (product_name, price, category, product_details,image_path) 
                                          VALUES (${newProduct.product_name}, 
                                                  ${newProduct.price}, 
                                                  ${newProduct.category}, 
                                                  ${newProduct.product_details},
                                                  ${newProduct.image_path})`;

    // Execute query with the appropriate product data
    sql:ExecutionResult result = check dbClient->execute(insertQuery);

    // Retrieve and return the last inserted ID if successful
    int|string? lastInsertId = result.lastInsertId;
    if lastInsertId is int {
        return lastInsertId;
    } else {
        return error("Failed to retrieve the last inserted ID");
    }
}

// Function to retrieve all products from the database
// isolated function getAllProducts() returns Product[]|error {
//     sql:ParameterizedQuery selectQuery = `SELECT product_id, product_name, price, category, product_details, image_path 
//                                            FROM products`;

//     // Create a stream from the query using the correct method for SELECT statements
//     stream<Product, sql:Error> productStream = check dbClient->query(selectQuery);

//     //     // Collect all products using a list
//     Product[] products = [];

//     // Using a foreach to collect products from the stream
//     foreach var result in productStream {
//         if result is Product {
//             products.push(result);
//         } else if result is sql:Error {
//             return error("Error retrieving products: " + result.message());
//         }
//     }

//     return products;
// }

// Function to login using email and password
isolated function loginByEmailPassword(string email, string password) returns string|error {
    // SQL query to retrieve user by email
    sql:ParameterizedQuery selectQuery = `SELECT first_name, password FROM users WHERE email = ${email}`;

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
