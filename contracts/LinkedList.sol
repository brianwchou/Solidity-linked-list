pragma solidity >=0.4.21 <0.6.0;

contract LinkedList {
    struct Node {
        string data;
        uint256 next;
    }

    mapping(uint256 => Node) list;
    uint256 private head;
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
        size = size + 1;
    }

    function appendAt(string memory item, uint256 index) public {
        require(index < size, "index not availiable");

        uint256 current = locate(index);

        uint256 next = list[current].next;

        uint256 hash = uint256(keccak256(abi.encodePacked(item)));

        list[current].next = hash;

        list[hash] = Node(item, next);
    }

    function removeFromHead() public {
        require(size > 0, "list is empty");

        uint256 temp = list[head].next;
        delete list[head];
        head = temp;
        size = size - 1;
    }

    function removeFrom(uint256 index) public {
        require(index < size, "index not availiable");

        if (index == 0) {
            removeFromHead();
            return;
        }

        uint256 prior = locate(index - 1);
        list[prior].next = list[list[prior].next].next;
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
