// Inspiration from here.
// https://ethereum.stackexchange.com/questions/48627/how-to-catch-revert-error-in-truffle-test-javascript
//
const PREFIX = 'VM Exception while processing transaction: '

const errTypes = {
  revert: 'revert',
  outOfGas: 'out of gas',
  invalidJump: 'invalid JUMP',
  invalidOpcode: 'invalid opcode',
  stackOverflow: 'stack overflow',
  stackUnderflow: 'stack underflow',
  staticStateChange: 'static state change'
}

const tryCatch = async (promise, errType) => {
  try {
    await promise
    throw null
  } catch (error) {
    assert(error, 'Expected a failure that did not happen')

    const prefix = `${PREFIX}${errType}`
    console.log('error.message:', error.message)
    assert(
      error.message.startsWith(prefix),
      `\nExpected: "${prefix}..."\n\nGot:      "${error.message}"`
    )
  }
}

module.exports = {
  errTypes,
  tryCatch
}
