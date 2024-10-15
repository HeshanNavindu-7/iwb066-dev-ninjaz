import ballerina/io;
import ballerinax/mysql;
import ballerina/sql;

type User record {
    int id?; // Optional field for the user's ID, set by the database
    string first_name;
    int age;
    string email;
    string phone_number;
    string password;
};

// Configurable variables for MySQL connection
configurable string HOST = ?;
configurable int PORT = ?;
configurable string USER = ?;
configurable string PASSWORD = ?;
configurable string DATABASE = ?;

// Initialize MySQL client
final mysql:Client dbClient = check new (host = HOST, port = PORT, user = USER, password = PASSWORD, database = DATABASE);

// Function to add a user to the database
isolated function addUser(User newUser) returns int|error {
    // Prepare the SQL query to insert user data
    sql:ParameterizedQuery insertQuery = `INSERT INTO users (first_name, age, email, phone_number, password) 
                                          VALUES (${newUser.first_name}, ${newUser.age}, ${newUser.email}, 
                                          ${newUser.phone_number}, ${newUser.password})`;

    // Execute the query
    sql:ExecutionResult result = check dbClient->execute(insertQuery);

    // Retrieve the last inserted ID
    int|string? lastInsertId = result.lastInsertId;
    if lastInsertId is int {
        return lastInsertId; // Return the ID of the newly added user
    } else {
        return error("Failed to retrieve the last inserted ID");
    }
}

public function main() returns error? {
    io:println("Ballerina service started...");
}
