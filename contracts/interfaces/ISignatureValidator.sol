// SPDX-License-Identifier: LGPL-3.0-only
pragma solidity >=0.7.0 <0.9.0;

contract ISignatureValidatorConstants {
    // bytes4(keccak256("isValidSignature(bytes,bytes)")
    bytes4 internal constant EIP1271_MAGIC_VALUE = 0x20c13b0b;
}

// 合约没有私钥，所以无法签名
// 可以实现这个 isValidSignature 方法以验证签名是否通过
// 其实还是由用户私钥来签名，然而这个方法实现里可以做其他验证，比如验证签名的用户地址是否有相应的权限
// 参见 https://eips.ethereum.org/EIPS/eip-1271
// 有点差别的是这里第一个参数是 data 而不是 data 的 hash，且 magicValue 也不一样
abstract contract ISignatureValidator is ISignatureValidatorConstants {
    /**
     * @dev Should return whether the signature provided is valid for the provided data
     * @param _data Arbitrary length data signed on the behalf of address(this)
     * @param _signature Signature byte array associated with _data
     *
     * MUST return the bytes4 magic value 0x20c13b0b when function passes.
     * MUST NOT modify state (using STATICCALL for solc < 0.5, view modifier for solc > 0.5)
     * MUST allow external calls
     */
    function isValidSignature(bytes memory _data, bytes memory _signature) public view virtual returns (bytes4);
}
