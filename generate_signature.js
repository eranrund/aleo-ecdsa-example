import { ethers } from "ethers";

/**
 * Convert a byte array to Leo/Aleo plaintext array format
 *
 * @param {Uint8Array|Array<number>} input - The byte array to convert
 * @returns {string} A string representation of the array in Leo format (e.g., "[1u8, 2u8, 3u8]")
 *
 * @example
 * const bytes = new Uint8Array([0x12, 0x34, 0x56]);
 * const plaintext = bytesToPlaintext(bytes);
 * // Returns: "[18u8, 52u8, 86u8]"
 */
export function bytesToPlaintext(input) {
    const arr = Array.isArray(input) ? input : Array.from(input);
    const body = arr.map(b => `${b}u8`).join(", ");
    return `[${body}]`;
}



const ethWallet = ethers.Wallet.createRandom();

const msg = "Hello, World!";

// Convert message to padded 32 bytes.
// Message has to be exactly 32 bytes since that's whats hardcoded in the ecdsa_example.aleo/main transition
const msgBytes = ethers.getBytes(ethers.encodeBytes32String(msg));

const sigHex = await ethWallet.signMessage(msgBytes);
const sigBytes = ethers.getBytes(sigHex);

// Get the Ethereum address bytes
const ethAddrBytes = ethers.getBytes(ethWallet.address);

console.log("Message:", ethers.hexlify(msgBytes));
console.log("Signature:", ethers.hexlify(sigBytes));
console.log("Ethereum Address:", ethWallet.address);

console.log("You may try this using the following Leo command on a local devnode:");
console.log(`$LEO execute --skip-execute-proof --broadcast --yes ecdsa_example.aleo/main '${bytesToPlaintext(msgBytes)}' '${bytesToPlaintext(ethAddrBytes)}' '${bytesToPlaintext(sigBytes)}'`)
