const SimpleBank = artifacts.require('./SimpleBank.sol')
const { tryCatch, errTypes } = require('./utils/exceptions')

contract('SimpleBank', async accounts => {
  const [owner, alice, bob] = accounts

  let bank

  beforeEach('setup contract for each test', async () => {
    bank = await SimpleBank.new()
  })

  it('should not let the same user enroll twice', async () => {
    const doubleDip = async () => {
      await bank.enroll({ from: alice })
      await bank.enroll({ from: alice })
    }
    await tryCatch(doubleDip(), errTypes.revert)
  })
})
