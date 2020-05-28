pragma solidity >=0.4.21 <0.7.0;
contract ZubToken {
    
    
    //name
    string public name = "Zub Token";
    //symbol for token
    string public symbol = "Z";
    //standard
    string public standard = "Zub Token v1.0";
    // totalSupply of tokens
    uint256 public totalSupply; //State variable for total Supply of tokens
    // owner's address
    address payable internal owner;
    // price of token
    uint256 internal price;
    // for recieve function
    uint256 _Value;


    // events 
     
    event Transfer(address _from, address _to, uint256 _value);
    event Approval(address _owner, address _to, uint256 _value);
    
    // mappings
    mapping(address => uint256) public balanceOf; // mapping for key address and balance

    mapping(address => mapping(address => uint256)) public allowance; // mapping for key address and balance

    // constructor
    constructor(uint256 _initialSupply, uint256 _setPrice) public {
        balanceOf[msg.sender] = _initialSupply;
        totalSupply = _initialSupply;
        owner = msg.sender;
        price == _setPrice ;
        //allocate initial Supply
    }
    
    //modifier only admin authority 
    modifier onlyOwner() {
        require(msg.sender == owner,"only owner can run this function");
            _;
        
    }
    // transfer function 
    function transfer(address _to, uint256 _value) public payable
        returns (bool success)
    {
        require(balanceOf[msg.sender] >= _value,'balance should be more then sent value');
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
    //approved  
    function approved(address _spender, uint256 _value)
        public
        returns (bool success)
    {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
    //transferFrom function
    function transferFrom(address _from, address _to, uint256 _value)public returns(bool success){
       require(_value <= balanceOf[_from], 'not sufficient blance');
       require(_value <= allowance[_from][msg.sender],'allowance should be maintained');
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;

        allowance[_from][msg.sender] -= _value;

        emit Transfer(_from, _to, _value);

        return(true); 
    }
    
    
    
    
    // function recieve(uint256 value) internal {
    //      require(value > 0 ether, "value should be paid in ether");
    //      balanceOf[owner]+=_Value;
    //      balanceOf[msg.sender]-= _Value;
    //      _Value = value;
    // }
    
    
    // fall back funtion for paying ether 
    //buyer is limited to EOA
    fallback () external payable {
        require(msg.value > 0 ether, "invailed amount");
        require(tx.origin == msg.sender,"should be external owned account");
        require(msg.sender != address(0), "buyer should have EOA");
        uint wei_unit = (1*10**18)/price;
        uint final_price = msg.value * wei_unit;
        balanceOf[owner] -= final_price;
        balanceOf[msg.sender] += final_price;
        address(uint160(owner)).transfer(msg.value);
     //   value = msg.value;
       // recieve;
    }
    
    //only owner can run this funtion 
    function adjustPrice(uint256 _newPrice) public onlyOwner() {
        price == _newPrice;
        
    }
    
}
