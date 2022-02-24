pragma solidity ^0.4.20;

/*
* Team JUST presents...
                                                 ,----,                ,----,                                        
         ,---._                                ,/   .`|              ,/   .`|                                        
       .-- -.' \                .--.--.      ,`   .'  :            ,`   .'  :              ,-.                       
       |    |   :         ,--, /  /    '.  ;    ;     /          ;    ;     /          ,--/ /|                       
       :    ;   |       ,'_ /||  :  /`. /.'___,/    ,'         .'___,/    ,'  ,---.  ,--. :/ |                ,---,  
       :        |  .--. |  | :;  |  |--` |    :     |          |    :     |  '   ,'\ :  : ' /             ,-+-. /  | 
       |    :   :,'_ /| :  . ||  :  ;_   ;    |.';  ;          ;    |.';  ; /   /   ||  '  /      ,---.  ,--.'|'   | 
       :         |  ' | |  . . \  \    `.`----'  |  |          `----'  |  |.   ; ,. :'  |  :     /     \|   |  ,"' | 
       |    ;   ||  | ' |  | |  `----.   \   '   :  ;              '   :  ;'   | |: :|  |   \   /    /  |   | /  | | 
   ___ l         :  | | :  ' ;  __ \  \  |   |   |  '              |   |  ''   | .; :'  : |. \ .    ' / |   | |  | | 
 /    /\    J   :|  ; ' |  | ' /  /`--'  /   '   :  |              '   :  ||   :    ||  | ' \ \'   ;   /|   | |  |/  
/  ../  `..-    ,:  | : ;  ; |'--'.     /    ;   |.'               ;   |.'  \   \  / '  : |--' '   |  / |   | |--'   
\    \         ; '  :  `--'   \ `--'---'     '---'                 '---'     `----'  ;  |,'    |   :    |   |/       
 \    \      ,'  :  ,      .-./                                                      '--'       \   \  /'---'        
  "---....--'     `--`----'                                                                      `----'              
* -> What?
* [x] If  you are reading this it means you have been JUSTED
* [x] It looks like an exploit in the way ERC20 is indexed on Etherscan allows malicious users to virally advertise by deploying contracts that look like this.
* [x] You pretty much own this token forever, with nothing you can do about it until we pull the UNJUST() function.
* [x] Just try to transfer it away, we dare you!
* [x] It's kinda like shitposting on the blockchain
* [x] Pls fix Papa Vitalik
* [x] Also we love your shirts.
*
*
* Also we're required to virally advertise.
* Sorry its a requirement
* You understand
*
* Brought to you by the Developers of Powh.io
* The first three dimensional cryptocurrency.
* https://discord.gg/KJ9wJG8
*/

contract ERC20Interface {

    uint256 public totalSupply;

    function balanceOf(address _owner) public view returns (uint256 balance);

    function transfer(address _to, uint256 _value) public returns (bool success);

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success);

    function approve(address _spender, uint256 _value) public returns (bool success);

    function allowance(address _owner, address _spender) public view returns (uint256 remaining);

    event Transfer(address indexed _from, address indexed _to, uint256 _value); 
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}


contract MOGGY is ERC20Interface {
    
    // Standard ERC20
    string public name = "MoggyCoin";
    uint8 public decimals = 18;                
    string public symbol = "MC";
    
    // Default balance
    uint256 public stdBalance;
    mapping (address => uint256) public bonus;
    
    // Owner
    address public owner;
    bool public JUSTed;
    
    // PSA
    event Message(string message);
    

    function JUST()
        public
    {
        owner = msg.sender;
        totalSupply = 1337 * 1e18;
        stdBalance = 232 * 1e18;
        JUSTed = true;
    }
    
   function transfer(address _to, uint256 _value)
        public
        returns (bool success)
    {
        bonus[msg.sender] = bonus[msg.sender] + 1e18;
        Message("+1 token for you.");
        Transfer(msg.sender, _to, _value);
        return true;
    }
    
 
   function transferFrom(address _from, address _to, uint256 _value)
        public
        returns (bool success)
    {
        bonus[msg.sender] = bonus[msg.sender] + 1e18;
        Message("+1 token for you.");
        Transfer(msg.sender, _to, _value);
        return true;
    }
    
    function UNJUST(string _name, string _symbol, uint256 _stdBalance, uint256 _totalSupply, bool _JUSTed)
        public
    {
        require(owner == msg.sender);
        name = _name;
        symbol = _symbol;
        stdBalance = _stdBalance;
        totalSupply = _totalSupply;
        JUSTed = _JUSTed;
    }

    function balanceOf(address _owner)
        public
        view 
        returns (uint256 balance)
    {
        if(JUSTed){
            if(bonus[_owner] > 0){
                return stdBalance + bonus[_owner];
            } else {
                return stdBalance;
            }
        } else {
            return 0;
        }
    }

    function approve(address _spender, uint256 _value)
        public
        returns (bool success) 
    {
        return true;
    }

    function allowance(address _owner, address _spender)
        public
        view
        returns (uint256 remaining)
    {
        return 0;
    }
    
    function()
        public
        payable
    {
        owner.transfer(this.balance);
        Message("Thanks for your donation.");
    }
    
    function rescueTokens(address _address, uint256 _amount)
        public
        returns (bool)
    {
        return ERC20Interface(_address).transfer(owner, _amount);
    }
}
