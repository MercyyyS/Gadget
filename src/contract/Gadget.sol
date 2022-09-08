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

contract Gadgets {
    uint private glassLength = 0;
    address private cUsdTokenAddress =
      0x874069Fa1Eb16D44d622F2e0Ca25eeA172369bC1;

    event likeGadgetEvent(address indexed userAddress, uint256 index);
    event dislikeGadgetEvent(address indexed userAddress, uint256 index);
    event deleteGadgetEvent(uint256 glassId);
    event buyGadgetEvent(
        address indexed seller,
        address indexed buyer,
        uint256 index
    );
    event addGadgetEvent(address indexed owner, uint256 gadgetId);

    struct Glass {
        address payable owner;
        string image;
        string name;
        string description;
        uint price;
        uint likesCount;
    }
    mapping(uint => Glass) internal glasses;
    mapping(uint256 => mapping(address => bool)) likes; // glasses liked by all users

    /// @dev  function to use to add glasses
    function addGlass(
        string calldata _image,
        string calldata _name,
        string calldata _description,
        uint _price
    ) external {
        require(bytes(_image).length > 0, "Empty image");
        require(bytes(_name).length > 0, "Empty name");
        require(bytes(_description).length > 0, "Empty description");
        require(_price > 0, "Price needs to be at least one wei");
        uint _likesCount = 0;
        glasses[glassLength] = Glass(
            payable(msg.sender),
            _image,
            _name,
            _description,
            _price,
            _likesCount
        );

        emit addGadgetEvent(msg.sender, glassLength);
        glassLength++;
    }

    /// @return glass details with key @index from glass mapping
    function getGlass(uint _index)
        public
        view
        returns (
            address payable,
            string memory,
            string memory,
            string memory,
            uint,
            uint
        )
    {
        return (
            glasses[_index].owner,
            glasses[_index].image,
            glasses[_index].name,
            glasses[_index].description,
            glasses[_index].price,
            glasses[_index].likesCount
        );
    }

    /// @dev delete glass with key @_index from books mapping
    function removeGlass(uint _index) external {
        require(msg.sender == glasses[_index].owner, "Only owner can delete ");
        glasses[_index] = glasses[glassLength - 1];
        delete glasses[glassLength - 1];
        glassLength--;

        emit deleteGadgetEvent(_index);
    }

    /**
     * @dev allow users to buy a glass from the platform
     */
    function buyGlass(uint _index) public payable {
        Glass storage currentGlass = glasses[_index];
        require(
            currentGlass.owner != msg.sender,
            "You can't buy your own glass"
        );
        require(
            IERC20Token(cUsdTokenAddress).transferFrom(
                msg.sender,
                glasses[_index].owner,
                glasses[_index].price
            ),
            "Transfer failed."
        );

        address seller = glasses[_index].owner;

        glasses[_index].owner = payable(msg.sender);

        emit buyGadgetEvent(seller, msg.sender, _index);
    }

    /**
     * @dev allow users to like or unlike a glass
     * @notice this function is used to like or dislike
     */
    function Like(uint _index) public {
        bool hasLiked = likes[_index][msg.sender];

        if (hasLiked) {
            likes[_index][msg.sender] = false;
            glasses[_index].likesCount--;
            emit dislikeGadgetEvent(msg.sender, _index);
        } else {
            likes[_index][msg.sender] = true;
            glasses[_index].likesCount++;
            emit likeGadgetEvent(msg.sender, _index);
        }
    }

    function getGlassesLength() public view returns (uint) {
        return (glassLength);
    }
}