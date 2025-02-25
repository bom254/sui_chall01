// Define the module
// Module are used to keep the code tidy and reusable
#[allow(duplicate_alias)]
module 0x0::simple_token {
    // Import necessary libraries
    use sui::object; // Grabs tools for making  objects like (Token) and UID
    use sui::tx_context; //Gets a tool that keeps track of the current transaction
    use sui::transfer; // Brings a tool to send stuff(like Token) to someone else

    // Define the Token struct (object)
    // key: lets the token to live in a global storage vault and be found by it's id
    // store: lets the token to packed into other thing and moved around
    public struct Token has key, store {
        id: object::UID,       // Unique ID for the token
        value: u64,    // Value of the token
    }

    // public fun: Anyone can use the function
    // Function to create a new Token
    public fun create_token(value: u64, ctx: &mut tx_context::TxContext): Token {
        // check that the value is greater than 0
        assert!(value > 0, 1); // stop if value is 0
        Token {
            id: object::new(ctx), // Generate a unique ID
            value,               // Set the token's value
        }
    }

    // Function to transfer the Token to another user
    public fun transfer_token(token: Token, recipient: address) {
        transfer::transfer(token, recipient); // Transfer ownership
    }

    // public entry: Anyone can call it, and it's meant to be the starting point to a
    // Example function to demonstrate creating and transferring a token
    public entry fun create_and_transfer_token(value: u64, recipient: address, ctx: &mut tx_context::TxContext) {
        // Step 1: Create a token with value 3000
        let token = create_token(value, ctx);

        // Step 2: Transfer the token to the given recipient
        transfer_token(token, recipient);
    }
}


