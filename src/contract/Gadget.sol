 // SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;


interface IERC20Token {
   function transfer(address, uint256) external returns (bool);

    function approve(address, uint256) external returns (bool);

    function transferFrom(
        address,
        address,
        uint256
    ) external returns (bool);

    function totalSupply() external view returns (uint256);

    function balanceOf(address) external view returns (uint256);

    function allowance(address, address) external view returns (uint256);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}
 
 contract   Gadgets{
    
    uint internal gadgetsLength = 0;
    uint256 internal gadgetsId = 0;
    address internal cUsdTokenAddress =   0x874069Fa1Eb16D44d622F2e0Ca25eeA172369bC1;

      
    event likeGadgetEvent(address indexed userAddress, uint256 index);
    event dislikeGadgetEvent(address indexed userAddress, uint256 index);
    event deleteGadgetEvent(uint256 glassId);
    event buyGadgetEvent(address indexed seller, address indexed buyer, uint256 index);
     event addGadgetEvent(address indexed owner, uint256 gadgetId);  

    struct  Gadget{
        address payable owner;
        uint256 gadgetId;
        string image;
        string name;
        string description;
         uint price;
         uint likesCount;
         
      
    }
      mapping (uint =>  Gadget) internal gadgets;
      mapping(uint256 => mapping(address => bool)) likes; // glasses liked by all users

      //  function use to add books
     function  addGadget(
        string memory _image, 
        string memory _name,
         string memory _description,
        uint _price
       
        
        
    ) public {
         uint _likesCount = 0;

         gadgets [gadgetsLength] =  Gadget(
            payable(msg.sender),
            gadgetsId,
            _image,
            _name,
            _description,
            _price,
             _likesCount
            
             
        );

        emit addGadgetEvent(msg.sender, gadgetsId);
        gadgetsLength++;
        gadgetsId++;
    
    }

    // return glass details with key @index from glass mapping
     function getGadget(uint _index) public view returns (
        address payable,
        uint256,
        string memory,
        string memory,  
        string memory,
        uint,
        uint
        
      
    ) {
        return (  
            gadgets[_index].owner,
               gadgets[_index].gadgetId,
                gadgets[_index].image,
              gadgets[_index].name, 
              gadgets[_index].description,
                gadgets[_index].price,
                gadgets[_index].likesCount


                   
        );
    }

    // delete glass with key @_index from books mapping
    function RemoveGlasses(uint _index) external {
	        require(msg.sender == gadgets[_index].owner, "Only owner can delete ");      
            uint256 gadgetId = gadgets[_index].gadgetId;      
            gadgets[_index] = gadgets[gadgetsLength - 1];// 
            delete gadgets[gadgetsLength - 1]; 
            gadgetsLength--; // 

            emit deleteGadgetEvent(gadgetId);
	    }

        
          function buyGlass(uint _index) public payable  {
        require(
          IERC20Token(cUsdTokenAddress).transferFrom(
            msg.sender,
            gadgets[_index].owner,
             gadgets[_index].price
          ),
          "Transfer failed."
        );

        address seller = gadgets[_index].owner;
        address buyer = msg.sender;

       gadgets[_index].owner = payable(msg.sender);

       emit buyGadgetEvent(seller, buyer, _index);
         
    }
 
     function Like (uint _index)public{
         bool hasLiked = likes[gadgets[_index].gadgetId][payable(msg.sender)];
    
         if (hasLiked) {
             likes[gadgets[_index].gadgetId][payable(msg.sender)] = false;
            gadgets[_index].likesCount--; 
            emit dislikeGadgetEvent(msg.sender, _index);
         } else {
       
             likes[gadgets[_index].gadgetId][payable(msg.sender)] = true;
             gadgets[_index].likesCount++;
             emit likeGadgetEvent(msg.sender, _index);
         }        
    } 

     
    function getgadgetsLength() public view returns (uint) {
        return (gadgetsLength);
    }
}

