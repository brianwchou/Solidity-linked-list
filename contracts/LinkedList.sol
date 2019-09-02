pragma solidity >=0.4.21 <0.6.0;

contract LinkedList {
    struct Node {
        string data;
        uint256 next;
    }

    mapping(uint256 => Node) list;
    Node private head;
    Node private tail;
    uint256 private size = 0;

    function appendAtHead(string memory item) public {
        
    }

    function appendAtTail(string memory item) public {

    }

    function appendAt(string memory item) public {

    }

    function removeFromHead() public {

    }

    function removeFromTail() public {

    }

    function removeFrom(uint256) public {

    }

    function length() public view returns(uint256) {
        return size;
    }

}
