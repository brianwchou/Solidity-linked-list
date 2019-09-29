pragma solidity >=0.4.21 <0.6.0;

contract LinkedList {
    struct HashedNode {
        string data;
        uint256 next;
    }

    mapping(uint256 => HashedNode) list;
    uint256 private head;
    uint256 private size = 0;

    event AppendEvent(string);
    event RemoveEvent(string);

    function appendAtHead(string memory item) public {
        uint256 hash = getDataHash(item);

        if (size == 0) {
            list[hash] = HashedNode(item, 0x0);
            head = hash;
        } else {
            list[hash] = HashedNode(item, head);
        }

        size = size + 1;
    }

    function appendAt(string memory item, uint256 index) public {
        require(index < size, "index not availiable");

        uint256 current = locate(index);

        uint256 next = list[current].next;

        uint256 hash = getDataHash(item);

        list[current].next = hash;

        list[hash] = HashedNode(item, next);
    }

    function removeFromHead() public {
        require(size > 0, "list is empty");

        uint256 temp = list[head].next;
        delete list[head];
        head = temp;
        size = size - 1;
    }

    function removeAt(uint256 index) public {
        require(index < size, "index not availiable");

        if (index == 0) {
            removeFromHead();
            return;
        }

        uint256 prior = locate(index - 1);
        uint256 nodeToDelete = list[prior].next;
        list[prior].next = list[nodeToDelete].next;
        delete list[nodeToDelete];

        size = size - 1;
    }

    function getAt(uint256 index) public view returns(string memory) {
        require(index < size, "index not availiable");

        uint256 pointer = locate(index);

        return list[pointer].data;
    }

    function length() public view returns(uint256) {
        return size;
    }

    function contains(string memory data) public view returns(bool) {
        uint256 hash = getDataHash(data);

        return compareStrings(list[hash].data, "");
    }

    function compareStrings(string memory a, string memory b) internal pure returns(bool) {
        return (keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b)));
    }

    function getDataHash(string memory item) internal pure returns(uint256) {
        return uint256(keccak256(abi.encodePacked(item)));
    }

    function locate(uint256 index) internal view returns(uint256) {
        uint256 i = 0;
        uint256 pointer = head;
        while(i <= index) {
            pointer = list[pointer].next;
            i = i - 1;
        }
        return pointer;
    }

}
