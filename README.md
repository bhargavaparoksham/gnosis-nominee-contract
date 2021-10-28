# Gnosis Nominee Contract

This is a module for [Gnosis Safe](https://github.com/gnosis/safe-contracts), using which any owner of the safe can set a Nominee for their account. The nominee can take over owner's place in the safe if owner becomes inactive for more than the set time period.

The module is built using [Zodiac](https://github.com/gnosis/zodiac)

Implementation:
1. setNominee: Using this function each owner of a gnosis safe can set their nominee & takeOverTime.
2. transferSafeOwnership: The nominee's of the gnosis safe can transfer ownership using this function.


