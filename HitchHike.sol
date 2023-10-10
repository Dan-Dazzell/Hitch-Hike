// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Hitchhike {
    struct UserProfile {
        string name;
        address walletAddress;
        UserType userType;
    }

    enum UserType { HitchHiker, HitchDriver }

    struct RideRequest {
        address hitchhiker;
        address payable driver; // Make the driver's address payable
        string currentLocation;
        string destination;
        uint256 cost;
        uint256 estimatedTime;
        bool isAccepted;
        bool isCompleted;
        bool passengerConfirmed;
        bool driverConfirmed;
        bool isCancelled;
    }

    struct RideDetails {
        address driver;
        string vehicleType;
        string currentLocation;
        uint256 cost;
        uint256 estimatedTime;
    }

    mapping(address => UserProfile) public users;
    mapping(address => RideRequest) public rideRequests;
    mapping(address => RideDetails) public rideDetails;

    event UserRegistered(address indexed walletAddress, string name, UserType userType);
    event UserLoggedIn(address indexed walletAddress, UserType userType);
    event RideRequested(address indexed hitchhiker, string currentLocation, string destination, uint256 cost, uint256 estimatedTime);
    event RideAccepted(address indexed hitchhiker, address indexed driver);
    event RideCompleted(address indexed hitchhiker, address indexed driver);
    event RideCancelled(address indexed hitchhiker, address indexed driver);

    modifier userDoesNotExist(address _walletAddress) {
        require(users[_walletAddress].walletAddress == address(0), "User already exists.");
        _;
    }

    modifier userExists(address _walletAddress) {
        require(users[_walletAddress].walletAddress != address(0), "User does not exist.");
        _;
    }

    modifier isRegisteredUser() {
        require(users[msg.sender].walletAddress != address(0), "You must register as a user.");
        _;
    }

    // Function to register a new user
    function registerUser(string memory _name, UserType _userType) public userDoesNotExist(msg.sender) {
        users[msg.sender] = UserProfile(_name, msg.sender, _userType);
        emit UserRegistered(msg.sender, _name, _userType);
    }

    // Function to log in a user
    function loginUser() public userExists(msg.sender) {
        UserType userType = users[msg.sender].userType;
        emit UserLoggedIn(msg.sender, userType);
    }

    // Function to request a ride
    function requestRide(
        string memory _currentLocation,
        string memory _destination,
        uint256 _cost,
        uint256 _estimatedTime,
        bool _isAccepted,
        bool _isCompleted,
        bool _passengerConfirmed,
        bool _driverConfirmed,
        bool _isCancelled
    ) public isRegisteredUser {
        require(rideRequests[msg.sender].hitchhiker == address(0), "You already have an active ride request.");

        // Create a new ride request
        rideRequests[msg.sender] = RideRequest(
            msg.sender,
            payable(address(0)), // Make the driver's address payable
            _currentLocation,
            _destination,
            _cost,
            _estimatedTime,
            _isAccepted,
            _isCompleted,
            _passengerConfirmed,
            _driverConfirmed,
            _isCancelled
        );

        // Emit an event to log the ride request
        emit RideRequested(msg.sender, _currentLocation, _destination, _cost, _estimatedTime);
    }

    // Rest of the contract (acceptRide, confirmRide, cancelRide, etc.)
}
