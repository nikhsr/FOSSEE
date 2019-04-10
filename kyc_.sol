pragma solidity ^0.5.0;


contract kyc {

    
    
    //citizen structure
    struct Citizen {
        string uname;        // Name
        uint adr;           // Aadhaar number
        string pan_no;      //permanent account number
        uint mobile_no;      //mobile number
        string photograph_ipfs_hash;//hash generated after image upload on ipfs
        string dob;         // date of birth
        
    }
    //organisation structure
    struct Organisation {
        string name;
        address ethAddress;
        string regNumber;
        
    }
     struct Request {
        string uname;
        address bank_ethereum_Address;
        bool isAllowed;
    }

    //  list of all customers

    Citizen[] allCustomers;

    //  list of all Banks/Organisations

    Organisation[] allOrgs;

    // list of all requests
    Request[] allRequests;


    
    mapping(address=>Organisation) org;
    mapping(address => Citizen) users;
    mapping(uint => address) aadhaarmap;
    
    
    
    function addUser(string memory _name, uint _aadhar,string memory _panno ,address _userId , uint _mobileno, string memory _photograph_ipfs_hash, string memory _dob ) public {

        // check if the user is previously registerd
        if(_aadhar != uint(0) && aadhaarmap[_aadhar] == address(0)) {

            users[_userId].uname = _name;
            users[_userId].adr = _aadhar;
            
            users[_userId].pan_no= _panno;
            users[_userId].mobile_no= _mobileno;
            users[_userId].photograph_ipfs_hash= _photograph_ipfs_hash;
            users[_userId].dob= _dob;
        }
    }
    
    // adding organisation
    function addBank(string memory uname, address eth,string memory regNum) public returns(bool)   {
        if(allOrgs.length == 0 || prevRegistered()) {
            allOrgs.length ++;
            allOrgs[allOrgs.length - 1] = Organisation(uname, eth, regNum);
            org[eth].name=uname;
            org[eth].ethAddress=eth;
            org[eth].regNumber=regNum;
           return true;
        }
        
        return false;
       
    }
    
    
    //internal functions
    function stringsEqual(string storage _a, string memory _b) internal returns (bool) {
		bytes storage a = bytes(_a);
		bytes memory b = bytes(_b);
		if (a.length != b.length)
			return false;
	
		for (uint i = 0; i < a.length; i ++)
        {
			if (a[i] != b[i])
				return false;
        }
		return true;
	}
    //internal function end
    
    
    
    

    function addRequest(string memory Uname, address bank_ethereum_Address) public returns(bool) {
        for(uint i = 0; i < allRequests.length; ++ i) {
            if(stringsEqual(allRequests[i].uname, Uname) && allRequests[i].bank_ethereum_Address == bank_ethereum_Address) {
                return true;
            }
        }
        allRequests.length ++;
        allRequests[allRequests.length - 1] = Request(Uname, bank_ethereum_Address, false);
    }
    
    function prevRegistered() public payable returns(bool) {
        for(uint i = 0; i < allOrgs.length; ++ i) {
            if(allOrgs[i].ethAddress == msg.sender)
                return true;
        }
        return false;
    }
    
    
    
    //allow bank to verify user
    function allowBank(string memory Uname, address bank_ethereum_Address, bool ifallowed) public payable {
        for(uint i = 0; i < allRequests.length; ++ i) {
            if(stringsEqual(allRequests[i].uname, Uname) && allRequests[i].bank_ethereum_Address == bank_ethereum_Address) {
                if(ifallowed==true) {
                    allRequests[i].isAllowed = true;
                } else {
                    for(uint j=i;j<allRequests.length-2; ++j) {
                        allRequests[i] = allRequests[i+1];
                    }
                    allRequests.length --;
                }
                return;
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    //view functions
    
    function getUser(address _userId) view public returns(string memory, uint,string memory,uint,string memory,string memory) {
        // return username, aadhaar-number, user-domain
        return (users[_userId].uname, users[_userId].adr, users[_userId].pan_no,
            users[_userId].mobile_no,
            users[_userId].photograph_ipfs_hash,
            users[_userId].dob);
    }
    
    
    function getOrganisation(address _eth) view public returns(string memory , address, string memory)
        {
        return (org[_eth].name, org[_eth].ethAddress, org[_eth].regNumber) ;   
        }
    
    
    
    
    
    
    
    
}   


