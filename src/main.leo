// The 'ecdsa_example' program.
program ecdsa_example.aleo {
    @noupgrade
    async constructor() {}

    async transition main(public message: [u8; 32], signer_eth_address: [u8; 20], sig: [u8; 65]) -> Future {
        return async {
            let digest = to_eth_signed_message_hash(message);
            assert(ECDSA::verify_digest_eth(sig, signer_eth_address, digest));
        };
    }

    inline to_eth_signed_message_hash(hash: [u8; 32]) -> [u8; 32] {
        let digest: [u8; 60] = [0u8; 60];

        // Ethereum Signed Message prefix: "\x19Ethereum Signed Message:\n32"
        digest[0] = 25u8;   // \x19
        digest[1] = 69u8;   // E
        digest[2] = 116u8;  // t
        digest[3] = 104u8;  // h
        digest[4] = 101u8;  // e
        digest[5] = 114u8;  // r
        digest[6] = 101u8;  // e
        digest[7] = 117u8;  // u
        digest[8] = 109u8;  // m
        digest[9] = 32u8;   // (space)
        digest[10] = 83u8;  // S
        digest[11] = 105u8; // i
        digest[12] = 103u8; // g
        digest[13] = 110u8; // n
        digest[14] = 101u8; // e
        digest[15] = 100u8; // d
        digest[16] = 32u8;  // (space)
        digest[17] = 77u8;  // M
        digest[18] = 101u8; // e
        digest[19] = 115u8; // s
        digest[20] = 115u8; // s
        digest[21] = 97u8;  // a
        digest[22] = 103u8; // g
        digest[23] = 101u8; // e
        digest[24] = 58u8;  // :
        digest[25] = 10u8;  // \n
        digest[26] = 51u8;  // '3'
        digest[27] = 50u8;  // '2'

        // Copy hash bytes (32 bytes)
        for i in 0u8..32u8 {
            digest[28u8 + i] = hash[i];
        }

        let hash_bits = Keccak256::hash_native_raw(digest);
        return Deserialize::from_bits_raw::[[u8; 32]](hash_bits);
    }
}
