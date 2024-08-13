// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

// Main execution
func main() {
    // Check if a file path was provided as a command-line argument
    guard CommandLine.arguments.count > 1 else {
        print("Error: Please provide the path to the input CSV file as a command-line argument.")
        print("Usage: swift main.swift /path/to/input/csv/file.csv [/path/to/output/csv/file.csv]")
        exit(1)
    }

    let inputFilePath = CommandLine.arguments[1]

    // Create subscribers from the CSV file
    let subscribers = createSubscribersFromCSV(filePath: inputFilePath)

    // Print the number of subscribers loaded
    print("Loaded \(subscribers.count) subscribers from \(inputFilePath)")

    let paid = subscribers.filter { $0.lastChargeStatus == "Paid" && $0.patronStatus == "Active patron" }
    let unpaid = subscribers.filter { $0.lastChargeStatus != "Paid" && $0.patronStatus != "Active patron" }
    
    // Print the number of paid subscribers
    print("Paid subscribers: \(paid.count)")
    print("Unpaid subscribers: \(unpaid.count)")
    
    #if false
    // Print each subscriber
    for (index, subscriber) in paid.enumerated() {
        print("\nSubscriber \(index + 1):")
        print("Name: \(subscriber.name)")
        print("Email: \(subscriber.email)")
        print("Discord: \(subscriber.discord ?? "N/A")")
        print("Patron Status: \(subscriber.patronStatus ?? "N/A")")
        print("Follows You: \(subscriber.followsYou)")
        print("Free Member: \(subscriber.freeMember)")
        print("Free Trial: \(subscriber.freeTrial)")
        print("Lifetime Amount: \(subscriber.lifetimeAmount)")
        print("Pledge Amount: \(subscriber.pledgeAmount)")
        print("Charge Frequency: \(subscriber.chargeFrequency ?? "N/A")")
        print("Tier: \(subscriber.tier)")
        print("User ID: \(subscriber.userID)")
        print("Last Updated: \(subscriber.lastUpdated)")
        print("Currency: \(subscriber.currency)")
        // Add more properties as needed
        print("--------------------")
    }
    #endif
    
    // Default output path if not provided
    let outputFilePath = CommandLine.arguments.count > 2 ? CommandLine.arguments[2] : "paid_subscribers.csv"

    // Create the paid subscribers CSV
    createPaidSubscriberCSV(subscribers: subscribers, outputPath: outputFilePath)
}

// Run the main function
main()
