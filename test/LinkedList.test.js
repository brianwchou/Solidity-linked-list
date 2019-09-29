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
        let snapshot = await util.takeSnapshot();
        snapshotId = snapshot.result
    });

    afterEach(async () => {
        await util.revertToSnapshot(snapshotId);
    });

    it('test length() with empty list', async () => {
        assert.equal(0, await list.length.call(), 'list should be empty');
    });

    it('test getAt() with empty list', async () => {
        const index = 0;
        await truffleAssert.reverts(list.getAt(index), 'index not availiable');
    });

    it('test appendAtHead() with empty list', async () => {
        const testString = 'test string';
        await list.appendAtHead(testString);

        // test length
        const size = await list.length.call();
        assert.equal(1, size, 'size did not increment');
    });

    it('test appendAtHead() with item in list', async () => {
        const testString1 = 'string1';
        const testString2 = 'string2';
        await list.appendAtHead(testString1);
        await list.appendAtHead(testString2);

        // test length
        const size = await list.length.call();
        assert.equal(2, size, 'size did not increment');
        const resultString = await list.getAt.call(1);
        assert.equal(resultString, testString1, 'should be first test string');
    });

    it('test getAt() with item in list', async () => {
        const testString = 'test string';
        await list.appendAtHead(testString);

        const returnedString = await list.getAt(0);
        assert.equal(returnedString, testString, 'values do not match');
    });

    it('test getAt() with item in list', async () => {
        const testString = 'test string';
        await list.appendAtHead(testString);

        const returnedString = await list.getAt(0);
        assert.equal(returnedString, testString, 'values do not match');
    });

    it('test appendAt() with empty list', async () => {
        const testString = 'test string';
        const index = 0;

        await truffleAssert.reverts(list.appendAt(testString, index), 'index not availiable');
    });

    it('test appendAt() with item in list', async () => {
        const testString = 'test string';
        const dummyString = 'dummy';
        const index = 0;
        await list.appendAtHead(dummyString);

        await list.appendAt(testString, index);

        const returnedString = await list.getAt(0);
        assert.equal(returnedString, testString, 'values do not match');
    });

    it('test contains() with item', async () => {
        const testString = 'thing';
        await list.appendAtHead(testString);
        
        assert(await list.appendAtHead(testString), `list does not contain ${testString}`);
    });

    it('test removeFromHead() with empty list', async () => {
        await truffleAssert.reverts(list.removeFromHead(), 'list is empty');
    });

    it('test removeFromHead() with item in list', async () => {
        const testString = 'test string';
        await list.appendAtHead(testString);

        await list.removeFromHead();

        const size = await list.length.call();
        assert.equal(0, size, 'list should be empty');
    });
    
    it('test removeAt() with 3 items in list removing from head', async () => {
        await list.appendAtHead('hello world');
        await list.appendAtHead('wooggly booggly');
        await list.appendAtHead('when does the narwal bacon');
        
        let size = await list.length.call();
        assert.equal(3, size, 'list have 3 items');
        await list.removeAt(0);

        size = await list.length.call();
        assert.equal(2, size, 'list have 3 items');

    });

    it('test removeAt() with 3 items in list removing from end', async () => {
        await list.appendAtHead('hello world');
        await list.appendAtHead('wooggly booggly');
        await list.appendAtHead('when does the narwal bacon');
        
        let size = await list.length.call();
        assert.equal(3, size, 'list have 3 items');
        await list.removeAt(2);

        size = await list.length.call();
        assert.equal(2, size, 'list have 3 items');
    });
});