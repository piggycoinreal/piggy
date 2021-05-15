pragma solidity ^0.8.2;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract Piggy {
    
    mapping (address => uint) public balances;
    mapping (address => mapping (address => uint)) public allowance;
    uint256 public totalsupply = 1000000000000000 * 10 ** 18;
    string public name = "Piggy Coin";
    string public symbol = "PIGGY";
    uint public decimals = 18;
    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);

    constructor () {
        balances[msg.sender] = totalsupply;
    }
    
    function balanceOf(address owner) public view returns(uint){
        return balances[owner];
    }
    
    function transfer(address to, uint value) public returns(bool) {
        require(balanceOf(msg.sender) >= value, 'Balance is Short');
        balances[to] += value;
        balances[msg.sender] -= value;
        emit Transfer(msg.sender, to, value);
        return true;
    }
    
    function transferFrom(address from, address to, uint value) public returns(bool) {
        require(balanceOf(from) >= value, 'Balance is Short');
        require(allowance[from][msg.sender] >= value, 'Allowance is Short');
        balances[to] += value;
        balances[from] -= value;
        emit Transfer(from, to, value);
        return true;
    }
    
    function approve(address spender, uint value) public returns(bool) {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }
}
