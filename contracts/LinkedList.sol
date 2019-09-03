pragma solidity >=0.4.21 <0.6.0;

contract LinkedList {
    struct Node {
        string data;
        uint256 next;
    }

    mapping(uint256 => Node) list;
    uint256 private head;
    uint256 private tail;
    uint256 private size = 0;

    event AppendEvent(string);
    event RemoveEvent(string);

    function appendAtHead(string memory item) public {
        if (size == 0) {
            uint256 hash = uint256(keccak256(abi.encodePacked(item)));
            list[hash] = Node(item, 0);
        }

        head = uint256(keccak256(abi.encodePacked(item)));
        list[head] = Node(item, head);
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

    function getAt() public {

    }

    function length() public view returns(uint256) {
        return size;
    }

}
