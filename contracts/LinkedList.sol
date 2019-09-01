pragma solidity >=0.4.21 <0.6.0;

contract LinkedList {
    struct Node {
        uint256 value;
        uint256 next;
    }

    mapping(uint256 => Node) list;
}
