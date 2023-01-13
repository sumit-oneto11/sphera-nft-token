// SPDX-License-Identifier: MIT
/**
working contract with tokenURI
- The smart contract ID is: 0.0.49249430

- The smart contract ID in Solidity format is: 0000000000000000000000000000000002ef7c96
 */
pragma solidity ^0.8.0;

import "./ERC1155.sol";

contract NFT_TOKEN is ERC1155 {
    address public owner;
    bool initialized;
    
    // Token name
    string private _name;

    // Token symbol 
    string private _symbol;

    // Token supply
    uint256 private tokenId;
 
    constructor()  ERC1155("https://oneto11.mypinata.cloud/ipfs/QmPx6kh1rKYt1WwSgimEEjL8gd4DeHvyqo59ytNVAifTid/") {}

    function initialize(string memory name_, string memory symbol_) public {
        require(!initialized,"Already Initialized!");
        initialized=true;
        _name   = name_;
        _symbol = symbol_;
        owner   = msg.sender;
    }

    function mint(address to, uint256 amount, bytes memory data) public returns(uint256) {
        require(msg.sender==owner,"Only Owner!");       
        tokenId++;     
        _mint(to, tokenId, amount, data);
        return tokenId;
    }

    function mintBatchForSingleAddress(address to,  uint256[] memory _tokenIds, uint256[] memory amount, bytes memory data) public {
        require(msg.sender==owner,"Only Owner!");   
        tokenId=tokenId+_tokenIds.length;
        _mintBatch(to, _tokenIds, amount, data); 
    }

    function mintBatchForDiffrentAddress(address[] memory to,  uint256[] memory _tokenIds, uint256[] memory amounts, bytes memory data) public {
        require(msg.sender==owner,"Only Owner!");
        require((to.length ==_tokenIds.length) && (_tokenIds.length == amounts.length), "Length mismatch!");
        tokenId=tokenId+_tokenIds.length;
        for(uint256 i = 0; i < _tokenIds.length; i++) {
            _mint(to[i], _tokenIds[i], amounts[i], data);
        }
    }

    function setURI(string memory newuri) public { 
        require(msg.sender==owner,"Only Owner!");   
        _setURI(newuri); 
    }  
    
    /**
     * @dev See {IERC1155-name} 
     */

    function name() public view returns(string memory) {
    return _name;
   }

   /**
     * @dev See {IERC1155-symbol}
     */

    function symbol() public view returns(string memory) {
    return _symbol;
   }

   /**
     * @dev See {IERC1155-totalSupply}
     */

    function totalSupply() public view returns(uint256){
        return tokenId;
    }

    /**
     * @dev See {IERC1155-burn token}
     */

    function burn(uint256 id, uint256 amount) public {
        _burn(msg.sender, id, amount);
    }

    /**
     * @dev See {IERC1155-burn token in batch}
     */

    function burn(uint256[] memory ids, uint256[] memory amounts) public {
        _burnBatch(msg.sender, ids, amounts);
    }

}