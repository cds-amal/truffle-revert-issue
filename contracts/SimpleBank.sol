pragma solidity ^0.4.24;


contract SimpleBank {

    mapping (address => uint) private balances;
    mapping (address => bool) private customers;

    address public owner;

    event LogDepositMade(address accountAddress, uint amount);

    modifier isCustomer(address _address) {
        require (
            customers[msg.sender] == true,
            "User is not a bank customer"
        );
        _;
    }

    modifier isNotCustomer() {
        require (
            customers[msg.sender] == false,
            "User is already a bank customer"
        );
        _;
    }

    constructor() public { owner = msg.sender; }

    function () public { revert(); }

    /// @notice Enroll a customer with the bank, giving them 1000 tokens for free
    /// @return The balance of the user after enrolling
    function enroll()
      public isNotCustomer()
      returns (uint)
    {
        // add new customer and set balance
        customers[msg.sender] = true;

        balances[msg.sender] = 1000;
        return balances[msg.sender];
    }

    /// @notice Deposit ether into bank
    /// @return The balance of the user after the deposit is made
    function deposit() public payable returns (uint) {
        balances[msg.sender] += msg.value;
        emit LogDepositMade(msg.sender, msg.value);
        return balances[msg.sender];
    }

    /// @notice Withdraw ether from bank
    /// @dev This does not return any excess ether sent to it
    /// @param withdrawAmount amount you want to withdraw
    /// @return The balance remaining for the user
    function withdraw(uint withdrawAmount) public payable returns (uint remainingBal) {
        require(balances[msg.sender] >= withdrawAmount);
        balances[msg.sender] -= withdrawAmount;
        return balances[msg.sender];
    }

    /// @notice Get balance
    /// @return The balance of the user
    function balance() public constant returns (uint) {
        return balances[msg.sender];
    }
}

