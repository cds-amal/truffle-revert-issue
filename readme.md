This project demonstrates an issue with testing exceptions with
[ganache-cli](https://github.com/trufflesuite/ganache-cli) where ganache-cli
behaves differently with a set blocktime vs no blocktime set.


With block time set `ganache-cli -b 1` the exception message includes the
transaction id with what seems like a developer hint message instead of
indicating what kind of error occurred.

```
Transaction: 0x3d45180a08e8c3696285352e2758da453c0e804f2f90df56593a3976c339acdd exited with an error (status 0).
Please check that the transaction:
    - satisfies all conditions set by Solidity `require` statements.
    - does not trigger a Solidity `revert` statement.
```

With no set block time `ganache-cli` the exception message explicitly states a
revert occurred.
```
'VM Exception while processing transaction: revert...'
```

# Screen cast demonstrating issue
  * [Asciinema screencast of
issue](https://asciinema.org/a/zWISMUH3Wum6pDMAex4zXI7IT)

# Versions
  * node: v9.11.2
  * truffle@4.1.12
  * ganache-cli@6.1.3


# Reproduce

1. git clone this repo
2. start ganache-cli -b 1
3. run `truffle test` and observe the error with transaction hint.

If you run `ganache-cli` with no blocktime set, you will see truffle test
fail with exception indicating a revert occurred.

