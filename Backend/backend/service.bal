import ballerina/http;
import ballerina/io;

service / on new http:Listener(8080) {


    // Resource to add a new user
    resource function post addUser(@http:Payload User user) returns http:Ok|error {
        int|error result = addUser(user);

        if result is int {
            // Respond with a success message and the new user's ID
            json response = {message: "User added successfully", userId: result};
            return {body: response};
        } else {
            // Log and return the error message
            io:println("Error adding user: ", result.message());
            return error("Failed to add user: " + result.message());
        }
    }
}
