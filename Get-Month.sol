// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract GetMonth {

    uint256 public currentMonth;

    function getCurrentMonth() public view returns (uint256 month) {
        uint256 epochDay = block.timestamp / 86400;
        
        assembly {
            epochDay := add(epochDay, 719468)
            let doe := mod(epochDay, 146097)
            let yoe := div(sub(sub(add(doe, div(doe, 36524)), div(doe, 1460)), eq(doe, 146096)), 365)
            let doy := sub(doe, sub(add(mul(365, yoe), shr(2, yoe)), div(yoe, 100)))
            let mp := div(add(mul(5, doy), 2), 153)
            month := sub(add(mp, 3), mul(gt(mp, 9), 12))
        }

        return month;
    }

    function setCurrenthMonth() public {
        currentMonth = getCurrentMonth();
    }
}