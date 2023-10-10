// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HitchHike { 
    struct RideRequest {
        address hitchhiker;
        string currentLocation;
        string destination;
        uint256 cost;
        uint256 estimatedTime;
        bool isAccepted;
        bool isCompleted;
    }

    struct RideDetails {
        address driver;
        string vehicleType;
        string currentLocation;
        uint256 cost;
        uint256 estimatedTime;
    }

    
}
