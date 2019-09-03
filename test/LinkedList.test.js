const LinkedList = artifacts.require('LinkedList');
const truffleAssert = require('truffle-assert');
const util = require('ganache-time-traveler');

contract('LinkedList', async () => {

    let list;
    let snapshotId;

    before(async () => {
        list = await LinkedList.new();
    });

    beforeEach(async () => {
        await util.takeSnapshot();
    });

    afterEach(async () => {
        await util.revertToSnapshot(snapshotId);
    });

    it('test length() with empty list', async () => {
        assert.equal(0, await list.length(), 'list should be empty');
    });

    it('test getAt() with empty list', async () => {
        const index = 0;
        await truffleAssert.reverts(list.getAt(index), 'index not availiable');
    });

    it('test appendAtHead() with empty list', async () => {
        const testString = 'test string';
        let tx = await list.appendAtHead(testString);

        // test length
        const size = await list.length();
        assert.equal(1, size, 'size did not increment');

        const returnedString = await list.getAt(0);
        assert.equal(returnedString, testString, 'values do not match');
    });
});