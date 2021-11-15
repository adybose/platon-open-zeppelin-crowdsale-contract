pragma solidity ^0.5.0 >=0.5.0 <0.9.0;

import "../../math/SafeMath.sol";
import "../Crowdsale.sol";

/**
 * @title CappedCrowdsale
 * @dev Crowdsale with a limit for total contributions.
 */
contract CappedCrowdsale is Crowdsale {
    using SafeMath for uint256;

    uint256 private _cap;

    /**
     * @dev Constructor, takes maximum amount of von accepted in the crowdsale.
     * @param cap Max amount of von to be contributed
     */
    constructor (uint256 cap) public {
        require(cap > 0, "CappedCrowdsale: cap is 0");
        _cap = cap;
    }

    /**
     * @return the cap of the crowdsale.
     */
    function cap() public view returns (uint256) {
        return _cap;
    }

    /**
     * @dev Checks whether the cap has been reached.
     * @return Whether the cap was reached
     */
    function capReached() public view returns (bool) {
        return vonRaised() >= _cap;
    }

    /**
     * @dev Extend parent behavior requiring purchase to respect the funding cap.
     * @param beneficiary Token purchaser
     * @param vonAmount Amount of von contributed
     */
    function _preValidatePurchase(address beneficiary, uint256 vonAmount) internal view {
        super._preValidatePurchase(beneficiary, vonAmount);
        require(vonRaised().add(vonAmount) <= _cap, "CappedCrowdsale: cap exceeded");
    }
}
